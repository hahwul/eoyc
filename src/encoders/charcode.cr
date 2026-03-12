require "./core"

# Charcode encode (decimal ASCII values with spaces)
Encoders.register(
  EncoderSpec.new(
    "charcode",
    %w[charcode charcode-encode],
    "Character code encode (decimal ASCII values)",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.charcode_encode(str) }
)

# Charcode decode
Encoders.register(
  EncoderSpec.new(
    "charcode-decode",
    %w[charcode-decode],
    "Character code decode",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.charcode_decode(str) }
)
