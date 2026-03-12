require "./core"

# HTML Entity Encode
Encoders.register(
  EncoderSpec.new(
    "html-encode",
    %w[html-encode html],
    "HTML entity encode",
    category: "encoding",
    flags: %w[encode reversible web]
  ) { |str| EncoderUtils.html_encode(str) }
)

# HTML Entity Decode
Encoders.register(
  EncoderSpec.new(
    "html-decode",
    %w[html-decode],
    "HTML entity decode",
    category: "encoding",
    flags: %w[decode reversible web]
  ) { |str| EncoderUtils.html_decode(str) }
)
