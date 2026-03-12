# Base64-related encoder registrations
require "./core"
require "base64"

# Standard Base64 encode
Encoders.register(
  EncoderSpec.new(
    "base64",
    %w[base64 base64-encode],
    "Base64 encode",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| Base64.encode(str) }
)

# Standard Base64 decode
Encoders.register(
  EncoderSpec.new(
    "base64-decode",
    %w[base64-decode],
    "Base64 decode",
    category: "encoding",
    flags: %w[decode reversible]
  ) do |str|
    begin
      Base64.decode_string(str)
    rescue
      str
    end
  end
)

# URL-safe Base64 encode (no padding)
Encoders.register(
  EncoderSpec.new(
    "base64-url",
    %w[base64-url base64-url-encode],
    "URL-safe Base64 encode (no padding)",
    category: "encoding",
    flags: %w[encode reversible url-safe]
  ) { |str| EncoderUtils.base64_url_encode(str) }
)

# URL-safe Base64 decode
Encoders.register(
  EncoderSpec.new(
    "base64-url-decode",
    %w[base64-url-decode],
    "URL-safe Base64 decode",
    category: "encoding",
    flags: %w[decode reversible url-safe]
  ) { |str| EncoderUtils.base64_url_decode(str) }
)

# Base32 encode (RFC 4648, with padding)
Encoders.register(
  EncoderSpec.new(
    "base32",
    %w[base32 base32-encode],
    "Base32 encode (RFC 4648, with padding)",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.base32_encode(str) }
)

# Base32 decode (RFC 4648)
Encoders.register(
  EncoderSpec.new(
    "base32-decode",
    %w[base32-decode],
    "Base32 decode (RFC 4648)",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.base32_decode(str) }
)

# CRC32 (IEEE 802.3) hex digest
Encoders.register(
  EncoderSpec.new(
    "crc32",
    %w[crc32 crc32-hex],
    "CRC32 hex digest (IEEE 802.3)",
    category: "hash",
    flags: %w[one-way checksum]
  ) { |str| EncoderUtils.crc32_hex(str) }
)

# URL-safe Base64 encode (with padding)
Encoders.register(
  EncoderSpec.new(
    "base64-url-pad",
    %w[base64-url-pad base64-url-encode-pad],
    "URL-safe Base64 encode (with padding)",
    category: "encoding",
    flags: %w[encode reversible url-safe]
  ) { |str| Base64.encode(str).gsub('+', '-').gsub('/', '_') }
)

# URL-safe Base64 decode (accepts padded or unpadded)
Encoders.register(
  EncoderSpec.new(
    "base64-url-pad-decode",
    %w[base64-url-pad-decode],
    "URL-safe Base64 decode (accepts padding)",
    category: "encoding",
    flags: %w[decode reversible url-safe]
  ) { |str| EncoderUtils.base64_url_decode(str) }
)
