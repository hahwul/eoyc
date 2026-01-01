# Core encoder framework
#
# This file provides the shared primitives for defining and using
# encoders / transformers inside the project.
#
# Responsibilities:
# - EncoderSpec: metadata + execution wrapper
# - Global registry with thread-safe registration
# - Lookup + help text generation
# - Chain execution (encode)
# - Shared utility helpers (EncoderUtils) for common low-level routines
#
# Usage (in another file):
#
#   require "./encoders/core"
#
#   Encoders.register(
#     EncoderSpec.new("base64", %w[base64 base64-encode], "Base64 encode") { |s|
#       Base64.encode(s)
#     }
#   )
#
#   # Then elsewhere:
#   output = encode("hello", ["base64"])
#
# Backward compatibility helpers:
#   available_encoders  -> Array(EncoderSpec)
#   encoder_help_lines  -> Array(String)
#   encode(str, encoders:Array(String)) -> String
#
# New preferred API (module scoped):
#   Encoders.specs
#   Encoders.help_lines
#   Encoders.encode_chain(str, encoders)
#
# NOTE: The chain semantics expect the provided encoders array to be
#       treated like a stack (last element applied first). The CLI
#       already reverses user input before passing it here.

require "mutex"
require "base64"

# Single specification for an encoder / transformer.
struct EncoderSpec
  getter primary : String
  getter names : Array(String)
  getter description : String
  getter proc : Proc(String, String)

  def initialize(primary : String, names : Array(String), description : String, &block : String -> String)
    unless names.includes?(primary)
      raise ArgumentError.new("Primary name '#{primary}' must be included in names array")
    end
    @primary = primary
    @names = names
    @description = description
    @proc = block
  end

  def apply(input : String) : String
    @proc.call(input)
  end

  def alias_list : Array(String)
    names.reject { |n| n == primary }
  end
end

# Shared helpers for encoder implementations.
module EncoderUtils
  extend self

  # Convert an array of UInt8 bytes to a String
  def bytes_to_string(bytes : Array(UInt8)) : String
    String.new(Bytes.new(bytes.to_unsafe, bytes.size))
  end

  # URL-safe Base64 (no padding)
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
    s.bytes.map(&.to_s(16).rjust(2, '0')).join
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

  def redact(s : String) : String
    "◼" * s.size
  end

  def bin_encode(s : String) : String
    s.bytes.map(&.to_s(2).rjust(8, '0')).join(" ")
  end

  def bin_decode(s : String) : String
    clean = s.strip
    # Split on spaces and try to convert each 8-bit binary string back to a byte
    parts = clean.split(/\s+/)
    bytes = [] of UInt8

    parts.each do |part|
      # Check if it's a valid 8-bit binary string
      if part =~ /^[01]{1,8}$/
        bytes << part.to_i(2).to_u8
      else
        # If invalid binary, return original string
        return s
      end
    end

    bytes_to_string(bytes)
  rescue
    s
  end

  def oct_encode(s : String) : String
    s.bytes.map(&.to_s(8).rjust(3, '0')).join
  end

  def oct_decode(s : String) : String
    clean = s.strip
    return s if clean.empty? || clean.size % 3 != 0

    # Each character should be exactly 3 octal digits
    bytes = [] of UInt8
    i = 0

    while i < clean.size
      chunk = clean[i, 3]
      if chunk =~ /^[0-7]{3}$/
        val = chunk.to_i(8)
        if val <= 255
          bytes << val.to_u8
          i += 3
        else
          return s # Invalid octal value > 255
        end
      else
        return s # Invalid octal format
      end
    end

    bytes_to_string(bytes)
  rescue
    s
  end

  def unicode_encode(s : String) : String
    s.each_char.map { |char| "\\u" + char.ord.to_s(16).rjust(4, '0') }.join
  end

  def unicode_decode(s : String) : String
    # Match \uXXXX patterns and convert back to characters
    decoded = s.gsub(/\\u([0-9a-fA-F]{4})/) do |_|
      code_point = $1.to_i(16)
      code_point.chr.to_s
    end
    decoded
  rescue
    s
  end

  def charcode_encode(s : String) : String
    s.bytes.map(&.to_s).join(" ")
  end

  def charcode_decode(s : String) : String
    clean = s.strip
    return s if clean.empty?

    # Split on spaces and try to convert each decimal string back to a byte
    parts = clean.split(/\s+/)
    bytes = [] of UInt8

    parts.each do |part|
      # Check if it's a valid decimal number
      if part =~ /^[0-9]+$/
        val = part.to_i
        if val >= 0 && val <= 255
          bytes << val.to_u8
        else
          return s # Invalid char code value
        end
      else
        return s # Invalid format
      end
    end

    bytes_to_string(bytes)
  rescue
    s
  end

  # Base32 (RFC 4648) encode with padding
  def base32_encode(s : String) : String
    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
    bits = 0_u32
    bits_left = 0
    out_len = 0
    String.build do |io|
      bytes = s.to_slice
      i = 0
      while i < bytes.size
        bits = (bits << 8) | bytes[i].to_u32
        bits_left += 8
        while bits_left >= 5
          val = ((bits >> (bits_left - 5)) & 0x1F).to_i
          io << alphabet[val]
          out_len += 1
          bits_left -= 5
        end
        i += 1
      end
      if bits_left > 0
        val = ((bits << (5 - bits_left)) & 0x1F).to_i
        io << alphabet[val]
        out_len += 1
        bits_left = 0
      end
      while out_len % 8 != 0
        io << '='
        out_len += 1
      end
    end
  rescue
    s
  end

  # Base32 (RFC 4648) decode
  def base32_decode(s : String) : String
    cleaned = s.upcase.gsub(/[^A-Z2-7=]/, "")
    bits = 0_u32
    bits_left = 0
    bytes = [] of UInt8

    cleaned.each_char do |ch|
      next if ch == '='
      val = case ch
            when 'A'..'Z' then ch.ord - 'A'.ord
            when '2'..'7' then ch.ord - '2'.ord + 26
            else
              return s
            end
      bits = (bits << 5) | val.to_u32
      bits_left += 5
      if bits_left >= 8
        byte = ((bits >> (bits_left - 8)) & 0xFF).to_u8
        bytes << byte
        bits_left -= 8
      end
    end

    bytes_to_string(bytes)
  rescue
    s
  end

  # CRC32 (IEEE 802.3) value as UInt32
  def crc32_uint(s : String) : UInt32
    crc = 0xFFFF_FFFF_u32
    s.each_byte do |b|
      crc ^= b.to_u32
      8.times do
        if (crc & 1_u32) == 1_u32
          crc = (crc >> 1) ^ 0xEDB8_8320_u32
        else
          crc >>= 1
        end
      end
    end
    crc ^ 0xFFFF_FFFF_u32
  rescue
    0_u32
  end

  # CRC32 hex string (lowercase, 8 chars)
  def crc32_hex(s : String) : String
    v = crc32_uint(s)
    v.to_s(16).rjust(8, '0')
  rescue
    "00000000"
  end
end

module Encoders
  extend self

  @@specs = [] of EncoderSpec
  @@name_to_spec = Hash(String, EncoderSpec).new
  @@mutex = Mutex.new

  # Register a new encoder specification.
  # If a name/alias already exists it will be overwritten by this spec.
  def register(spec : EncoderSpec)
    @@mutex.synchronize do
      @@specs << spec
      spec.names.each do |n|
        @@name_to_spec[n.downcase] = spec
      end
    end
  end

  # Return all registered specs (in registration order).
  def specs : Array(EncoderSpec)
    @@specs
  end

  # Lookup a spec by any name or alias (case-insensitive).
  def find(name : String) : EncoderSpec?
    @@name_to_spec[name.downcase]?
  end

  # Produce lines suited for help output.
  def help_lines : Array(String)
    specs.map do |spec|
      aliases = spec.alias_list
      alias_part = aliases.empty? ? "" : " (aliases: #{aliases.join(", ")})"
      "#{spec.primary.ljust(17)} - #{spec.description}#{alias_part}"
    end
  end

  # Apply a chain of encoders (mutates the passed encoders array via pop).
  def encode_chain(str, encoders : Array(String)) : String
    current = str.to_s
    return current.strip if current.empty? || encoders.empty?

    while encoders.size > 0
      name = encoders.pop.to_s.strip.downcase
      spec = find(name)
      current = if spec
                  begin
                    spec.apply(current)
                  rescue
                    current
                  end
                else
                  current
                end
    end
    current.to_s.strip
  end
end

# Backward-compatible top-level functions (existing callers rely on these).

def available_encoders : Array(EncoderSpec)
  Encoders.specs
end

def encoder_help_lines : Array(String)
  Encoders.help_lines
end

def encode(str, encoders)
  # Accept nil gracefully (Crystal type flexibility)
  ary = encoders.as(Array(String))
  Encoders.encode_chain(str, ary)
end
