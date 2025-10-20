# Base64-related encoder registrations
#
# This file defines and registers:
#  - base64 / base64-encode
#  - base64-decode
#  - base64-url / base64-url-encode
#  - base64-url-decode
#
# Depends on:
#   - ./core.cr (EncoderSpec, Encoders, EncoderUtils)
#
# NOTE:
#   If the legacy monolithic encoders registry (encoders.cr) still
#   contains these specs, you should remove them there to avoid
#   duplicate registrations (not harmful, but redundant).

require "./core"
require "base64"

# Standard Base64 encode
Encoders.register(
  EncoderSpec.new(
    "base64",
    %w[base64 base64-encode],
    "Base64 encode"
  ) { |s| Base64.encode(s) }
)

# Standard Base64 decode
Encoders.register(
  EncoderSpec.new(
    "base64-decode",
    %w[base64-decode],
    "Base64 decode"
  ) do |s|
    begin
      Base64.decode_string(s)
    rescue
      s
    end
  end
)

# URL-safe Base64 encode (no padding)
Encoders.register(
  EncoderSpec.new(
    "base64-url",
    %w[base64-url base64-url-encode],
    "URL-safe Base64 encode (no padding)"
  ) { |s| EncoderUtils.base64_url_encode(s) }
)

# URL-safe Base64 decode
Encoders.register(
  EncoderSpec.new(
    "base64-url-decode",
    %w[base64-url-decode],
    "URL-safe Base64 decode"
  ) { |s| EncoderUtils.base64_url_decode(s) }
)

# Base32 encode (RFC 4648, with padding)
Encoders.register(
  EncoderSpec.new(
    "base32",
    %w[base32 base32-encode],
    "Base32 encode (RFC 4648, with padding)"
  ) { |s| EncoderUtils.base32_encode(s) }
)

# Base32 decode (RFC 4648)
Encoders.register(
  EncoderSpec.new(
    "base32-decode",
    %w[base32-decode],
    "Base32 decode (RFC 4648)"
  ) { |s| EncoderUtils.base32_decode(s) }
)

# CRC32 (IEEE 802.3) hex digest
Encoders.register(
  EncoderSpec.new(
    "crc32",
    %w[crc32 crc32-hex],
    "CRC32 hex digest (IEEE 802.3)"
  ) { |s| EncoderUtils.crc32_hex(s) }
)

# URL-safe Base64 encode (with padding)
Encoders.register(
  EncoderSpec.new(
    "base64-url-pad",
    %w[base64-url-pad base64-url-encode-pad],
    "URL-safe Base64 encode (with padding)"
  ) { |s| Base64.encode(s).gsub('+', '-').gsub('/', '_') }
)

# URL-safe Base64 decode (accepts padded or unpadded)
Encoders.register(
  EncoderSpec.new(
    "base64-url-pad-decode",
    %w[base64-url-pad-decode],
    "URL-safe Base64 decode (accepts padding)"
  ) { |s| EncoderUtils.base64_url_decode(s) }
)
