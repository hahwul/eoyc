require "./core"

# Leet Speak
Encoders.register(
  EncoderSpec.new(
    "leet",
    %w[leet l33t],
    "Leet speak transform"
  ) { |str| EncoderUtils.leet(str) }
)
