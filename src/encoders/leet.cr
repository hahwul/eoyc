require "./core"

# Leet Speak
Encoders.register(
  EncoderSpec.new(
    "leet",
    %w[leet l33t],
    "Leet speak transform",
    category: "transform",
    flags: %w[one-way transform]
  ) { |str| EncoderUtils.leet(str) }
)
