require "./core"

# JSON String Escape
Encoders.register(
  EncoderSpec.new(
    "json-escape",
    %w[json-escape json],
    "JSON string escape"
  ) { |s| EncoderUtils.json_escape(s) }
)

# JSON String Unescape
Encoders.register(
  EncoderSpec.new(
    "json-unescape",
    %w[json-unescape],
    "JSON string unescape"
  ) { |s| EncoderUtils.json_unescape(s) }
)
