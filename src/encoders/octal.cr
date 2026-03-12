require "./core"

# Octal encode
Encoders.register(
  EncoderSpec.new(
    "oct",
    %w[oct oct-encode],
    "Octal (base 8) encode",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.oct_encode(str) }
)

# Octal decode
Encoders.register(
  EncoderSpec.new(
    "oct-decode",
    %w[oct-decode],
    "Octal decode",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.oct_decode(str) }
)
