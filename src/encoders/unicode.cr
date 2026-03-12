require "./core"

# Unicode encode
Encoders.register(
  EncoderSpec.new(
    "unicode",
    %w[unicode unicode-encode],
    "Unicode escape sequence encode",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.unicode_encode(str) }
)

# Unicode decode
Encoders.register(
  EncoderSpec.new(
    "unicode-decode",
    %w[unicode-decode],
    "Unicode escape sequence decode",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.unicode_decode(str) }
)
