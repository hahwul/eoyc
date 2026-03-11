require "./core"

# Morse Code Encode
Encoders.register(
  EncoderSpec.new(
    "morse-encode",
    %w[morse-encode morse],
    "Morse code encode"
  ) { |str| EncoderUtils.morse_encode(str) }
)

# Morse Code Decode
Encoders.register(
  EncoderSpec.new(
    "morse-decode",
    %w[morse-decode],
    "Morse code decode"
  ) { |str| EncoderUtils.morse_decode(str) }
)
