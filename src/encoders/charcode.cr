# Charcode encoder registrations
#
# Provides:
#   charcode / charcode-encode   -> Character code encode (decimal ASCII values with spaces)
#   charcode-decode              -> Character code decode
#
# Depends on:
#   ./core (EncoderSpec, Encoders, EncoderUtils)
#
# Encoding behavior:
#   "abcd" => "97 98 99 100"
# Decoding behavior:
#   "97 98 99 100" => "abcd"
#   Invalid input returns the original string (fail-safe).

require "./core"

# Charcode encode (decimal ASCII values with spaces)
Encoders.register(
  EncoderSpec.new(
    "charcode",
    %w[charcode charcode-encode],
    "Character code encode (decimal ASCII values with spaces)"
  ) { |s| EncoderUtils.charcode_encode(s) }
)

# Charcode decode
Encoders.register(
  EncoderSpec.new(
    "charcode-decode",
    %w[charcode-decode],
    "Character code decode"
  ) { |s| EncoderUtils.charcode_decode(s) }
)
