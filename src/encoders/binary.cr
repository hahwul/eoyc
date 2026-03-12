require "./core"

# Binary encode (8-bit with spaces)
Encoders.register(
  EncoderSpec.new(
    "bin",
    %w[bin bin-encode],
    "Binary (8-bit) encode with spaces",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.bin_encode(str) }
)

# Binary decode
Encoders.register(
  EncoderSpec.new(
    "bin-decode",
    %w[bin-decode],
    "Binary decode",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.bin_decode(str) }
)
