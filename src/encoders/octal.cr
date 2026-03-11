# Octal encoder registrations
#
# Provides:
#   oct / oct-encode   -> Octal encode (base 8)
#   oct-decode         -> Octal decode
#
# Depends on:
#   ./core (EncoderSpec, Encoders, EncoderUtils)
#
# Encoding behavior:
#   "a" => "141" (97 in decimal = 141 in octal)
#   "abc" => "141142143"
# Decoding behavior:
#   "141142143" => "abc"
#   Invalid octal input returns the original string (fail-safe).

require "./core"

# Octal encode
Encoders.register(
  EncoderSpec.new(
    "oct",
    %w[oct oct-encode],
    "Octal (base 8) encode"
  ) { |str| EncoderUtils.oct_encode(str) }
)

# Octal decode
Encoders.register(
  EncoderSpec.new(
    "oct-decode",
    %w[oct-decode],
    "Octal decode"
  ) { |str| EncoderUtils.oct_decode(str) }
)
