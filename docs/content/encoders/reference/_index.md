+++
title = "Encoder Reference"
weight = 3
+++

# Encoder Reference

Complete technical reference for all EOYC encoders.

## Base64 Encoders

### `base64` (alias: `base64-encode`)
Standard Base64 encoding as defined in RFC 4648.

```bash
echo "hello" | eoyc -e "base64"
# Output: aGVsbG8=
```

**Technical Details:**
- Uses standard Base64 alphabet (A-Z, a-z, 0-9, +, /)
- Includes padding characters (=)
- Output is always valid Base64

### `base64-decode`
Decodes standard Base64 encoded strings.

```bash
echo "aGVsbG8=" | eoyc -e "base64-decode"
# Output: hello
```

**Error Handling:**
- Invalid Base64 input returns original string
- Missing padding is handled gracefully

### `base64-url` (alias: `base64-url-encode`)
URL-safe Base64 encoding without padding.

```bash
echo "hello???" | eoyc -e "base64-url"
# Output: aGVsbG8_Pz8
```

**Technical Details:**
- Uses URL-safe alphabet (A-Z, a-z, 0-9, -, _)
- No padding characters
- Safe for use in URLs and filenames

### `base64-url-decode`
Decodes URL-safe Base64 strings.

```bash
echo "aGVsbG8_Pz8" | eoyc -e "base64-url-decode"
# Output: hello???
```

## Hash/Digest Encoders

### `md5`
MD5 hash function returning hex digest.

```bash
echo "password" | eoyc -e "md5"
# Output: 5f4dcc3b5aa765d61d8327deb882cf99
```

**Security Note:** MD5 is cryptographically broken. Use for non-security purposes only.

### `sha1`
SHA-1 hash function returning Base64 digest.

```bash
echo "password" | eoyc -e "sha1"
# Output: W6ph5Mm5Pz8GgiULbPgzG37mj9g=
```

### `sha1-hex`
SHA-1 hash function returning hex digest.

```bash
echo "password" | eoyc -e "sha1-hex"
# Output: 5baa61e4c9b93f3f0682250b6cf8331b7ee68fd8
```

### `sha256`
SHA-256 hash function returning Base64 digest.

```bash
echo "password" | eoyc -e "sha256"
# Output: XohImNooBHFR0OVvjcYpJ3AfPUfGaZTrqWcKGLxNr8=
```

**Recommended:** Most secure hash function for general use.

### `sha256-hex`
SHA-256 hash function returning hex digest.

```bash
echo "password" | eoyc -e "sha256-hex"
# Output: 5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8
```

### `sha512`
SHA-512 hash function returning Base64 digest.

```bash
echo "password" | eoyc -e "sha512"
# Output: sQnzu7wkTrgkQZF+0G1hi5AI3Qmzvv0bXgc5THBqi7mAsdd4Xll27ASbRt9fEyavWi6m0QP9B8lThf+rDKy8hg==
```

### `sha512-hex`
SHA-512 hash function returning hex digest.

```bash
echo "password" | eoyc -e "sha512-hex"
# Output: b109f3bbbc244eb8244191fef06d618b9008dd09b3befd1b5e07394c7062d8bb8081d77785e5976ec049b46df5f132b1f562ea6d903fd07c95385ffab0cac8bc8e
```

## Hex Encoders

### `hex` (alias: `hex-encode`)
Converts bytes to hexadecimal representation (lowercase).

```bash
echo "ABC" | eoyc -e "hex"
# Output: 414243
```

### `hex-decode`
Converts hexadecimal strings back to bytes.

```bash
echo "414243" | eoyc -e "hex-decode"
# Output: ABC
```

**Input Requirements:**
- Even number of hex digits
- Valid hex characters (0-9, a-f, A-F)
- Invalid input returns original string

## URL Encoders

### `url` (alias: `url-encode`)
Percent-encoding as defined in RFC 3986.

```bash
echo "hello world!" | eoyc -e "url"
# Output: hello%20world%21
```

**Characters Encoded:**
- Spaces become %20
- Special characters get percent-encoded
- Safe characters (A-Z, a-z, 0-9, -, ., _, ~) remain unchanged

### `url-decode`
Decodes percent-encoded URLs.

```bash
echo "hello%20world%21" | eoyc -e "url-decode"
# Output: hello world!
```

## Text Transformations

### `upcase`
Converts all characters to uppercase.

```bash
echo "Hello World" | eoyc -e "upcase"
# Output: HELLO WORLD
```

### `downcase`
Converts all characters to lowercase.

```bash
echo "Hello World" | eoyc -e "downcase"
# Output: hello world
```

### `reverse`
Reverses the order of characters.

```bash
echo "hello" | eoyc -e "reverse"
# Output: olleh
```

### `rot13`
ROT13 substitution cipher (A-Z, a-z only).

```bash
echo "hello world" | eoyc -e "rot13"
# Output: uryyb jbeyq
```

**Technical Details:**
- Only affects letters (A-Z, a-z)
- Numbers and special characters unchanged
- Self-inverse (applying twice returns original)

### `redacted` (alias: `redaction`)
Replaces all characters with block characters (█).

```bash
echo "sensitive data" | eoyc -e "redacted"
# Output: █████████████
```

**Use Cases:**
- Log sanitization
- Data privacy compliance
- Visual redaction for screenshots

## Binary/Octal Encoders

### `bin` (alias: `bin-encode`)
Converts characters to 8-bit binary representation with spaces.

```bash
echo "ABC" | eoyc -e "bin"
# Output: 01000001 01000010 01000011
```

### `bin-decode`
Converts binary strings back to characters.

```bash
echo "01000001 01000010 01000011" | eoyc -e "bin-decode"
# Output: ABC
```

**Input Format:**
- 8-bit binary numbers
- Space-separated
- Invalid input returns original string

### `oct` (alias: `oct-encode`)
Converts characters to octal representation.

```bash
echo "ABC" | eoyc -e "oct"
# Output: 101102103
```

### `oct-decode`
Converts octal strings back to characters.

```bash
echo "101102103" | eoyc -e "oct-decode"
# Output: ABC
```

**Input Format:**
- 3-digit octal numbers (concatenated)
- Valid octal digits (0-7)

## Unicode/Character Encoders

### `unicode` (alias: `unicode-encode`)
Converts characters to Unicode code point notation.

```bash
echo "hello" | eoyc -e "unicode"
# Output: U+0068U+0065U+006CU+006CU+006F
```

### `unicode-decode`
Converts Unicode notation back to characters.

```bash
echo "U+0068U+0065U+006CU+006CU+006F" | eoyc -e "unicode-decode"
# Output: hello
```

**Input Format:**
- U+XXXX format
- Hexadecimal code points
- Concatenated (no spaces)

### `charcode` (alias: `charcode-encode`)
Converts characters to decimal ASCII values with spaces.

```bash
echo "ABC" | eoyc -e "charcode"
# Output: 65 66 67
```

### `charcode-decode`
Converts decimal ASCII values back to characters.

```bash
echo "65 66 67" | eoyc -e "charcode-decode"
# Output: ABC
```

**Input Format:**
- Space-separated decimal numbers
- Valid ASCII range (0-127 recommended)
- Invalid codes are skipped

## Performance Characteristics

### Fast Encoders
- `upcase`, `downcase`, `reverse`
- `hex`, `hex-decode`
- `url`, `url-decode`

### Medium Performance
- `base64`, `base64-decode`
- `bin`, `oct` (and decodes)
- `unicode`, `charcode`

### Slower Encoders (Cryptographic)
- `md5`
- `sha1`, `sha1-hex`
- `sha256`, `sha256-hex`
- `sha512`, `sha512-hex`

## Error Handling

All encoders follow these principles:
1. **Graceful degradation** - Invalid input returns original string
2. **No exceptions** - Encoders never crash the program
3. **Silent failure** - Errors don't generate warnings
4. **Chain continuation** - Failed encoders don't break chains

## Implementation Notes

- All encoders are implemented in Crystal
- Hash functions use Crystal's built-in digest library
- Text encoders use Unicode-aware string operations
- Binary encoders handle multibyte characters correctly