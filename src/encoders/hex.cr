# Hex encoder registrations
#
# Provides:
#   hex / hex-encode   -> Hex (lowercase) encode
#   hex-decode         -> Hex decode
#
# Depends on:
#   ./core (EncoderSpec, Encoders, EncoderUtils)
#
# NOTE:
# If hex encoders are still present in the legacy monolithic encoders.cr,
# whichever definition loads last will override earlier registrations for
# the same names/aliases (this is fine—implementations are equivalent).
#
# Encoding behavior:
#   "ABC" => "414243"
# Decoding behavior:
#   Valid even-length hex (case-insensitive) is converted back to bytes
#   and then to String (assuming UTF-8 or binary-safe). Invalid input
#   returns the original string (fail-safe).

require "./core"

# Hex encode (lowercase)
Encoders.register(
  EncoderSpec.new(
    "hex",
    %w[hex hex-encode],
    "Hex (lowercase) encode"
  ) { |str| EncoderUtils.hex_encode(str) }
)

# Hex decode
Encoders.register(
  EncoderSpec.new(
    "hex-decode",
    %w[hex-decode],
    "Hex decode"
  ) { |str| EncoderUtils.hex_decode(str) }
)
