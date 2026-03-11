require "./core"

# JSON String Escape
Encoders.register(
  EncoderSpec.new(
    "json-escape",
    %w[json-escape json],
    "JSON string escape"
  ) { |str| EncoderUtils.json_escape(str) }
)

# JSON String Unescape
Encoders.register(
  EncoderSpec.new(
    "json-unescape",
    %w[json-unescape],
    "JSON string unescape"
  ) { |str| EncoderUtils.json_unescape(str) }
)
