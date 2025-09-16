# Unicode encoder registrations
#
# Provides:
#   unicode / unicode-encode   -> Unicode escape sequence encode (e.g., "a" → "\u0061")
#   unicode-decode             -> Unicode escape sequence decode (e.g., "\u0061" → "a")
#
# Depends on:
#   ./core (EncoderSpec, Encoders, EncoderUtils)
#
# Encoding behavior:
#   "a" => "\u0061"
#   "hello" => "\u0068\u0065\u006c\u006c\u006f"
# Decoding behavior:
#   Valid \uXXXX sequences are converted back to characters.
#   Invalid input returns the original string (fail-safe).

require "./core"

# Unicode encode
Encoders.register(
  EncoderSpec.new(
    "unicode",
    %w[unicode unicode-encode],
    "Unicode escape sequence encode"
  ) { |s| EncoderUtils.unicode_encode(s) }
)

# Unicode decode
Encoders.register(
  EncoderSpec.new(
    "unicode-decode",
    %w[unicode-decode],
    "Unicode escape sequence decode"
  ) { |s| EncoderUtils.unicode_decode(s) }
)
