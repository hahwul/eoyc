require "./core"

# Morse Code Encode
Encoders.register(
  EncoderSpec.new(
    "morse",
    %w[morse morse-encode],
    "Morse code encode",
    category: "cipher",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.morse_encode(str) }
)

# Morse Code Decode
Encoders.register(
  EncoderSpec.new(
    "morse-decode",
    %w[morse-decode],
    "Morse code decode",
    category: "cipher",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.morse_decode(str) }
)
