require "./core"

# ASCII85/Base85 Encode
Encoders.register(
  EncoderSpec.new(
    "ascii85-encode",
    %w[ascii85-encode ascii85],
    "ASCII85/Base85 encode",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.ascii85_encode(str) }
)

# ASCII85/Base85 Decode
Encoders.register(
  EncoderSpec.new(
    "ascii85-decode",
    %w[ascii85-decode],
    "ASCII85/Base85 decode",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.ascii85_decode(str) }
)
