require "./core"

# Punycode Encode
Encoders.register(
  EncoderSpec.new(
    "punycode-encode",
    %w[punycode-encode punycode],
    "Punycode encode (IDN)"
  ) { |s| EncoderUtils.punycode_encode(s) }
)

# Punycode Decode
Encoders.register(
  EncoderSpec.new(
    "punycode-decode",
    %w[punycode-decode],
    "Punycode decode"
  ) { |s| EncoderUtils.punycode_decode(s) }
)
