require "./core"

# JSON String Escape
Encoders.register(
  EncoderSpec.new(
    "json-escape",
    %w[json-escape json],
    "JSON string escape",
    category: "encoding",
    flags: %w[encode reversible web]
  ) { |str| EncoderUtils.json_escape(str) }
)

# JSON String Unescape
Encoders.register(
  EncoderSpec.new(
    "json-unescape",
    %w[json-unescape],
    "JSON string unescape",
    category: "encoding",
    flags: %w[decode reversible web]
  ) { |str| EncoderUtils.json_unescape(str) }
)
