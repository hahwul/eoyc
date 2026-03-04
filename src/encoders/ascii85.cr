require "./core"

# ASCII85/Base85 Encode
Encoders.register(
  EncoderSpec.new(
    "ascii85-encode",
    %w[ascii85-encode ascii85],
    "ASCII85/Base85 encode"
  ) { |s| EncoderUtils.ascii85_encode(s) }
)

# ASCII85/Base85 Decode
Encoders.register(
  EncoderSpec.new(
    "ascii85-decode",
    %w[ascii85-decode],
    "ASCII85/Base85 decode"
  ) { |s| EncoderUtils.ascii85_decode(s) }
)
