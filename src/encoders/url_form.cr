# URL form encoding/decoding encoders
#
# Registers:
#  - url / url-encode      : form-style encode (single value)
#  - url-decode            : form-style decode
#
# Behavior:
#  - Encoding uses URI.encode_www_form on the raw string (single value semantics)
#  - Decoding uses URI.decode_www_form and returns the resulting String
#  - Fail-safe: on exception returns original input
#
# NOTE:
#  If earlier monolithic encoders.cr file still contains these
#  registrations, whichever file is required last wins.

require "./core"
require "uri"

# Encode
Encoders.register(
  EncoderSpec.new(
    "url",
    %w[url url-encode],
    "application/x-www-form-urlencoded encode"
  ) do |s|
    begin
      URI.encode_www_form(s)
    rescue
      s
    end
  end
)

# Decode
Encoders.register(
  EncoderSpec.new(
    "url-decode",
    %w[url-decode],
    "application/x-www-form-urlencoded decode"
  ) do |s|
    begin
      URI.decode_www_form(s)
    rescue
      s
    end
  end
)
