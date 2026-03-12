require "./core"

# Punycode Encode
Encoders.register(
  EncoderSpec.new(
    "punycode-encode",
    %w[punycode-encode punycode],
    "Punycode encode (IDN)",
    category: "encoding",
    flags: %w[encode reversible web]
  ) { |str| EncoderUtils.punycode_encode(str) }
)

# Punycode Decode
Encoders.register(
  EncoderSpec.new(
    "punycode-decode",
    %w[punycode-decode],
    "Punycode decode",
    category: "encoding",
    flags: %w[decode reversible web]
  ) { |str| EncoderUtils.punycode_decode(str) }
)
