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
