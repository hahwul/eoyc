# Binary encoder registrations
#
# Provides:
#   bin / bin-encode   -> Binary encode (8-bit representation with spaces)
#   bin-decode         -> Binary decode
#
# Depends on:
#   ./core (EncoderSpec, Encoders, EncoderUtils)
#
# Encoding behavior:
#   "abc" => "01100001 01100010 01100011"
# Decoding behavior:
#   "01100001 01100010 01100011" => "abc"
#   Invalid binary input returns the original string (fail-safe).

require "./core"

# Binary encode (8-bit with spaces)
Encoders.register(
  EncoderSpec.new(
    "bin",
    %w[bin bin-encode],
    "Binary (8-bit) encode with spaces"
  ) { |s| EncoderUtils.bin_encode(s) }
)

# Binary decode
Encoders.register(
  EncoderSpec.new(
    "bin-decode",
    %w[bin-decode],
    "Binary decode"
  ) { |s| EncoderUtils.bin_decode(s) }
)
