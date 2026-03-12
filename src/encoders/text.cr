# Text transform encoder registrations
require "./core"

# ROT13
Encoders.register(
  EncoderSpec.new(
    "rot13",
    %w[rot13],
    "ROT13 substitution cipher",
    category: "cipher",
    flags: %w[encode decode reversible symmetric]
  ) { |str| EncoderUtils.rot13(str) }
)

# Uppercase
Encoders.register(
  EncoderSpec.new(
    "upcase",
    %w[upcase],
    "Uppercase transform",
    category: "transform",
    flags: %w[transform text]
  ) { |str| str.upcase }
)

# Lowercase
Encoders.register(
  EncoderSpec.new(
    "downcase",
    %w[downcase],
    "Lowercase transform",
    category: "transform",
    flags: %w[transform text]
  ) { |str| str.downcase }
)

# Reverse
Encoders.register(
  EncoderSpec.new(
    "reverse",
    %w[reverse],
    "Reverse text",
    category: "transform",
    flags: %w[transform reversible symmetric]
  ) { |str| str.reverse }
)

# Redaction
Encoders.register(
  EncoderSpec.new(
    "redacted",
    %w[redacted redaction],
    "Replace all characters with blocks",
    category: "transform",
    flags: %w[one-way transform]
  ) { |str| EncoderUtils.redact(str) }
)

# ROT47
Encoders.register(
  EncoderSpec.new(
    "rot47",
    %w[rot47],
    "ROT47 cipher (printable ASCII)",
    category: "cipher",
    flags: %w[encode decode reversible symmetric]
  ) { |str| EncoderUtils.rot47(str) }
)

# Atbash
Encoders.register(
  EncoderSpec.new(
    "atbash",
    %w[atbash],
    "Atbash cipher (reverse alphabet)",
    category: "cipher",
    flags: %w[encode decode reversible symmetric]
  ) { |str| EncoderUtils.atbash(str) }
)
