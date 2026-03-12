require "./core"
require "uri"

# URL encode
Encoders.register(
  EncoderSpec.new(
    "url",
    %w[url url-encode],
    "URL encode (application/x-www-form-urlencoded)",
    category: "encoding",
    flags: %w[encode reversible web]
  ) do |str|
    begin
      URI.encode_www_form(str)
    rescue
      str
    end
  end
)

# URL decode
Encoders.register(
  EncoderSpec.new(
    "url-decode",
    %w[url-decode],
    "URL decode (application/x-www-form-urlencoded)",
    category: "encoding",
    flags: %w[decode reversible web]
  ) do |str|
    begin
      URI.decode_www_form(str)
    rescue
      str
    end
  end
)
