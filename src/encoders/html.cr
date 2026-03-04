require "./core"

# HTML Entity Encode
Encoders.register(
  EncoderSpec.new(
    "html-encode",
    %w[html-encode html],
    "HTML entity encode"
  ) { |s| EncoderUtils.html_encode(s) }
)

# HTML Entity Decode
Encoders.register(
  EncoderSpec.new(
    "html-decode",
    %w[html-decode],
    "HTML entity decode"
  ) { |s| EncoderUtils.html_decode(s) }
)
