---
title: "Hex Encoders"
weight: 3
---

Hexadecimal encoding converts each byte to its two-digit hexadecimal representation.

## hex

**Aliases:** `hex-encode`

Encodes text to lowercase hexadecimal representation.

### Usage

```bash
echo "hello" | eoyc -e "hex"
# Output: 68656c6c6f
```

### How It Works

Each character is converted to its hexadecimal ASCII value:
- 'h' (104) → 68
- 'e' (101) → 65
- 'l' (108) → 6c
- 'l' (108) → 6c
- 'o' (111) → 6f

### Examples

```bash
echo "ABC" | eoyc -e "hex"
# Output: 414243

echo "test123" | eoyc -e "hex"
# Output: 74657374313233
```

## hex-decode

Decodes hexadecimal strings back to original text.

### Usage

```bash
echo "68656c6c6f" | eoyc -e "hex-decode"
# Output: hello
```

### Examples

```bash
echo "414243" | eoyc -e "hex-decode"
# Output: ABC

echo "74657374313233" | eoyc -e "hex-decode"
# Output: test123
```

## Round-Trip Example

```bash
# Encode then decode
original="Hello World"
encoded=$(echo "$original" | eoyc -e "hex")
decoded=$(echo "$encoded" | eoyc -e "hex-decode")

echo "Original: $original"
echo "Encoded: $encoded"
echo "Decoded: $decoded"
```

## Use Cases

- Representing binary data in text format
- Debugging and inspecting byte values
- Color codes and data serialization
- Low-level data manipulation

## Chaining with Hex

```bash
# Hex encode then Base64
echo "data" | eoyc -e "hex>base64"

# Hash then hex encode (redundant since most hashes already output hex)
echo "data" | eoyc -e "sha256>hex"
```
