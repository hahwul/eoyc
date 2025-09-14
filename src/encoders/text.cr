# Text transform encoder registrations
#
# Provides simple, stateless text transformers:
#   rot13      -> ROT13 substitution
#   upcase     -> Uppercase
#   downcase   -> Lowercase
#   reverse    -> Reverse string
#   redacted   -> Replace every character with the block '◼'
#
# Depends on:
#   ./core (EncoderSpec, Encoders, EncoderUtils)
#
# NOTE:
# If these were already defined in the legacy monolithic encoders.cr,
# whichever file loads last will "win" for each alias. That is fine
# because all implementations are idempotent and side‑effect free.

require "./core"

# ROT13
Encoders.register(
  EncoderSpec.new(
    "rot13",
    %w[rot13],
    "ROT13 substitution cipher"
  ) { |s| EncoderUtils.rot13(s) }
)

# Uppercase
Encoders.register(
  EncoderSpec.new(
    "upcase",
    %w[upcase],
    "Uppercase transform"
  ) { |s| s.upcase }
)

# Lowercase
Encoders.register(
  EncoderSpec.new(
    "downcase",
    %w[downcase],
    "Lowercase transform"
  ) { |s| s.downcase }
)

# Reverse
Encoders.register(
  EncoderSpec.new(
    "reverse",
    %w[reverse],
    "Reverse text"
  ) { |s| s.reverse }
)

# Redaction
Encoders.register(
  EncoderSpec.new(
    "redacted",
    %w[redacted redaction],
    "Replace all characters with blocks"
  ) { |s| EncoderUtils.redact(s) }
)
