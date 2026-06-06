require "./core"

# Base58 (Bitcoin alphabet) encode
# Avoids 0OIl characters for human readability (used in BTC addresses, etc.)
Encoders.register(
  EncoderSpec.new(
    "base58",
    %w[base58 base58-encode],
    "Base58 encode (Bitcoin alphabet)",
    category: "encoding",
    flags: %w[encode reversible]
  ) { |str| EncoderUtils.base58_encode(str) }
)

# Base58 decode
Encoders.register(
  EncoderSpec.new(
    "base58-decode",
    %w[base58-decode],
    "Base58 decode (Bitcoin alphabet)",
    category: "encoding",
    flags: %w[decode reversible]
  ) { |str| EncoderUtils.base58_decode(str) }
)
