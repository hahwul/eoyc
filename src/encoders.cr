# Encoder / Transformer Registry
#
# This file refactors the previous case-statement based implementation
# into a structured registry with metadata to enable:
# - Easy addition/removal of encoders
# - Programmatic listing (for help output in CLI)
# - Alias support
#
# Public API:
#   encode(str, encoders : Array(String))            -> String
#   available_encoders                               -> Array(EncoderSpec)
#   encoder_help_lines                               -> Array(String)
#
# Each encoder guarantees a String return (best-effort). Failures fall
# back to returning the original input for resilience in chained mode.
#
# Chain semantics (backward compatible):
# - The provided encoders array is treated like a stack (pop order), so
#   the last element in the array is applied first—consistent with the
#   previous implementation where the caller reversed user input.

require "base64"
require "digest/md5"
require "digest/sha1"
require "digest/sha256"
require "digest/sha512"
require "uri"

# Specification object for each encoder / transformer
struct EncoderSpec
  getter primary : String
  getter names : Array(String)
  getter description : String
  getter proc : Proc(String, String)

  def initialize(primary : String, names : Array(String), description : String, &block : String -> String)
    @primary = primary
    @names = names
    @description = description
    @proc = block
  end

  def apply(input : String) : String
    @proc.call(input)
  end

  def alias_list : Array(String)
    names - [primary]
  end
end

# Helper utilities (kept internal)
module EncoderUtils
  extend self

  def base64_url_encode(s : String) : String
    Base64.encode(s).gsub('+', '-').gsub('/', '_').gsub(/=+$/, "")
  end

  def base64_url_decode(s : String) : String
    work = s.tr("-", "+").tr("_", "/")
    padding = (4 - work.size % 4) % 4
    work += "=" * padding
    Base64.decode_string(work)
  rescue
    s
  end

  def hex_encode(s : String) : String
    s.bytes.map { |b| b.to_s(16).rjust(2, '0') }.join
  end

  def hex_decode(s : String) : String
    clean = s.strip
    return s unless clean.size.even? && clean =~ /^[0-9a-fA-F]+$/
    bytes = Bytes.new(clean.size // 2)
    i = 0
    bi = 0
    while i < clean.size
      bytes[bi] = clean[i, 2].to_i(16).to_u8
      i += 2
      bi += 1
    end
    String.new(bytes)
  rescue
    s
  end

  def rot13(s : String) : String
    s.tr("A-Za-z", "N-ZA-Mn-za-m")
  end

  # URL form encode/decode consistency:
  # - For encode we mimic previous behavior (encode_www_form on raw string)
  # - For decode we keep previous approach (decode_www_form) but try to
  #   gracefully return a meaningful string.
  def url_form_encode(s : String) : String
    # Using raw string to mimic form encoding of a single value.
    URI.encode_www_form(s)
  end

  def url_form_decode(s : String) : String
    URI.decode_www_form(s)
  rescue
    s
  end

  def redact(s : String) : String
    "◼" * s.size
  end
end

# Registry definition
ENCODER_SPECS = [
  # Base64 (standard)
  EncoderSpec.new("base64", %w[base64 base64-encode], "Base64 encode") { |s| Base64.encode(s) },
  EncoderSpec.new("base64-decode", %w[base64-decode], "Base64 decode") { |s| Base64.decode_string(s) },

  # Base64 URL-safe
  EncoderSpec.new("base64-url", %w[base64-url base64-url-encode], "URL-safe Base64 encode (no padding)") { |s| EncoderUtils.base64_url_encode(s) },
  EncoderSpec.new("base64-url-decode", %w[base64-url-decode], "URL-safe Base64 decode") { |s| EncoderUtils.base64_url_decode(s) },

  # Digests (hex + base64)
  EncoderSpec.new("md5", %w[md5], "MD5 hex digest") { |s| Digest::MD5.hexdigest(s) },

  EncoderSpec.new("sha1", %w[sha1], "SHA1 Base64 digest") { |s| Digest::SHA1.base64digest(s) },
  EncoderSpec.new("sha1-hex", %w[sha1-hex], "SHA1 hex digest") { |s| Digest::SHA1.hexdigest(s) },

  EncoderSpec.new("sha256", %w[sha256], "SHA256 Base64 digest") { |s| Digest::SHA256.base64digest(s) },
  EncoderSpec.new("sha256-hex", %w[sha256-hex], "SHA256 hex digest") { |s| Digest::SHA256.hexdigest(s) },

  EncoderSpec.new("sha512", %w[sha512], "SHA512 Base64 digest") { |s| Digest::SHA512.base64digest(s) },
  EncoderSpec.new("sha512-hex", %w[sha512-hex], "SHA512 hex digest") { |s| Digest::SHA512.hexdigest(s) },

  # URL form encoding
  EncoderSpec.new("url", %w[url url-encode], "application/x-www-form-urlencoded encode") { |s| EncoderUtils.url_form_encode(s) },
  EncoderSpec.new("url-decode", %w[url-decode], "application/x-www-form-urlencoded decode") { |s| EncoderUtils.url_form_decode(s) },

  # Hex
  EncoderSpec.new("hex", %w[hex hex-encode], "Hex (lowercase) encode") { |s| EncoderUtils.hex_encode(s) },
  EncoderSpec.new("hex-decode", %w[hex-decode], "Hex decode") { |s| EncoderUtils.hex_decode(s) },

  # ROT13
  EncoderSpec.new("rot13", %w[rot13], "ROT13 substitution cipher") { |s| EncoderUtils.rot13(s) },

  # Case transforms
  EncoderSpec.new("upcase", %w[upcase], "Uppercase transform") { |s| s.upcase },
  EncoderSpec.new("downcase", %w[downcase], "Lowercase transform") { |s| s.downcase },

  # Reverse
  EncoderSpec.new("reverse", %w[reverse], "Reverse text") { |s| s.reverse },

  # Redaction
  EncoderSpec.new("redacted", %w[redacted redaction], "Replace all characters with blocks") { |s| EncoderUtils.redact(s) },
] of EncoderSpec

# Build alias lookup map (lowercased)
NAME_TO_SPEC = begin
  map = Hash(String, EncoderSpec).new
  ENCODER_SPECS.each do |spec|
    spec.names.each do |n|
      map[n.downcase] = spec
    end
  end
  map
end

# Returns list of encoder specifications
def available_encoders : Array(EncoderSpec)
  ENCODER_SPECS
end

# Human-readable lines suitable for help display
def encoder_help_lines : Array(String)
  available_encoders.map do |spec|
    aliases = spec.alias_list
    alias_part = aliases.empty? ? "" : " (aliases: #{aliases.join(", ")})"
    "#{spec.primary.ljust(14)} - #{spec.description}#{alias_part}"
  end
end

# Core chain processor (backward compatible name)
def encode(str, encoders) : String
  # Accept nil / non-string gracefully
  current = str.to_s
  return current.strip if current.empty? || encoders.nil? || encoders.empty?

  name = encoders.pop.to_s.strip.downcase
  spec = NAME_TO_SPEC[name]?

  next_value = if spec
                 begin
                   spec.apply(current)
                 rescue ex
                   # Fail-safe: keep original segment on error
                   current
                 end
               else
                 # Unknown encoder: ignore and keep value
                 current
               end

  encode(next_value, encoders)
end
