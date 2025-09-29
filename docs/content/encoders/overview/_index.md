+++
title = "Encoder Overview"
weight = 1
+++

# Encoder Overview

EOYC supports a wide variety of encoding, hashing, and transformation operations. All encoders can be used individually or chained together for complex transformations.

## Available Encoders

### Base64 Encoders
- **`base64`** (alias: `base64-encode`) - Standard Base64 encoding
- **`base64-decode`** - Base64 decoding
- **`base64-url`** (alias: `base64-url-encode`) - URL-safe Base64 encoding (no padding)
- **`base64-url-decode`** - URL-safe Base64 decoding

```bash
echo "hello" | eoyc -e "base64"
# Output: aGVsbG8=

echo "aGVsbG8=" | eoyc -e "base64-decode"
# Output: hello
```

### Hash/Digest Encoders
- **`md5`** - MD5 hex digest
- **`sha1`** - SHA1 Base64 digest
- **`sha1-hex`** - SHA1 hex digest
- **`sha256`** - SHA256 Base64 digest
- **`sha256-hex`** - SHA256 hex digest
- **`sha512`** - SHA512 Base64 digest
- **`sha512-hex`** - SHA512 hex digest

```bash
echo "password" | eoyc -e "sha256"
# Output: XohImNooBHFR0OVvjcYpJ3AfPUfGaZTNqWcKGLxNr8=

echo "password" | eoyc -e "sha256-hex"
# Output: 5e8848854e011e2a6ae5b19db7c43e39df35f6c7d3ba34b5bc88d1f0ecdf5e7
```

### Hex Encoders
- **`hex`** (alias: `hex-encode`) - Hex (lowercase) encoding
- **`hex-decode`** - Hex decoding

```bash
echo "hello" | eoyc -e "hex"
# Output: 68656c6c6f

echo "68656c6c6f" | eoyc -e "hex-decode"
# Output: hello
```

### URL Encoders
- **`url`** (alias: `url-encode`) - application/x-www-form-urlencoded encoding
- **`url-decode`** - URL decoding

```bash
echo "hello world!" | eoyc -e "url"
# Output: hello%20world%21

echo "hello%20world%21" | eoyc -e "url-decode"
# Output: hello world!
```

### Text Transformations
- **`rot13`** - ROT13 substitution cipher
- **`upcase`** - Convert to uppercase
- **`downcase`** - Convert to lowercase
- **`reverse`** - Reverse text
- **`redacted`** (alias: `redaction`) - Replace all characters with blocks (█)

```bash
echo "Hello World" | eoyc -e "upcase"
# Output: HELLO WORLD

echo "sensitive data" | eoyc -e "redacted"
# Output: █████████████
```

### Binary/Octal Encoders
- **`bin`** (alias: `bin-encode`) - Binary (8-bit) encoding with spaces
- **`bin-decode`** - Binary decoding
- **`oct`** (alias: `oct-encode`) - Octal (base 8) encoding
- **`oct-decode`** - Octal decoding

```bash
echo "ABC" | eoyc -e "bin"
# Output: 01000001 01000010 01000011

echo "ABC" | eoyc -e "oct"
# Output: 101102103
```

### Unicode/Character Encoders
- **`unicode`** (alias: `unicode-encode`) - Unicode encoding (U+XXXX format)
- **`unicode-decode`** - Unicode decoding
- **`charcode`** (alias: `charcode-encode`) - Character code encoding (decimal ASCII values)
- **`charcode-decode`** - Character code decoding

```bash
echo "hello" | eoyc -e "unicode"
# Output: U+0068U+0065U+006CU+006CU+006F

echo "ABC" | eoyc -e "charcode"
# Output: 65 66 67
```

## Encoder Categories

### Security & Hashing
Perfect for password hashing, data integrity checks, and creating unique identifiers:
- `md5`, `sha1`, `sha256`, `sha512` (and their hex variants)

### Data Encoding
For safe data transmission and storage:
- `base64`, `hex`, `url`, `bin`, `oct`

### Text Processing
For text manipulation and obfuscation:
- `upcase`, `downcase`, `reverse`, `rot13`, `redacted`

### Development & Debugging
For character analysis and debugging:
- `unicode`, `charcode`

## Error Handling

EOYC handles encoding errors gracefully:
- Invalid input for decoders returns the original string
- Unknown encoders are ignored
- Malformed chains continue with valid encoders

## Performance Notes

- Hash functions are cryptographically secure but slower
- Simple transformations (upcase, reverse) are very fast
- Base64 and hex operations are optimized for performance
- Binary operations may be slower for large inputs

## Next Steps

- [Encoder Chaining](/encoders/chaining) - Combine multiple encoders
- [Encoder Reference](/encoders/reference) - Complete technical reference
- [Usage Examples](/usage/examples) - Real-world scenarios