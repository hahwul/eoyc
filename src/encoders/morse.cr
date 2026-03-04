require "./core"

# Morse Code Encode
Encoders.register(
  EncoderSpec.new(
    "morse-encode",
    %w[morse-encode morse],
    "Morse code encode"
  ) { |s| EncoderUtils.morse_encode(s) }
)

# Morse Code Decode
Encoders.register(
  EncoderSpec.new(
    "morse-decode",
    %w[morse-decode],
    "Morse code decode"
  ) { |s| EncoderUtils.morse_decode(s) }
)
