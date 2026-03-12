# Hex encoder registrations
require "./core"

# Hex encode (lowercase)
Encoders.register(
  EncoderSpec.new(
    "hex",
    %w[hex hex-encode],
    "Hex (lowercase) encode",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.hex_encode(str) }
)

# Hex decode
Encoders.register(
  EncoderSpec.new(
    "hex-decode",
    %w[hex-decode],
    "Hex decode",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.hex_decode(str) }
)
