---
title: "Base64 Encoders"
weight: 1
---

Base64 encoding is a binary-to-text encoding scheme that represents binary data in an ASCII string format.

## base64

**Aliases:** `base64-encode`

Standard Base64 encoding with padding.

### Usage

```bash
echo "hello" | eoyc -e "base64"
# Output: aGVsbG8=
```

### Example

```bash
echo "test data" | eoyc -e "base64"
# Output: dGVzdCBkYXRh
```

## base64-decode

Decode Base64 encoded strings back to original text.

### Usage

```bash
echo "aGVsbG8=" | eoyc -e "base64-decode"
# Output: hello
```

### Example

```bash
echo "dGVzdCBkYXRh" | eoyc -e "base64-decode"
# Output: test data
```

## base64-url

**Aliases:** `base64-url-encode`

URL-safe Base64 encoding without padding. Uses `-` and `_` instead of `+` and `/` to be URL-safe.

### Usage

```bash
echo "hello world" | eoyc -e "base64-url"
# Output: aGVsbG8gd29ybGQ
```

### Use Cases

- Encoding data for URLs and filenames
- JWT tokens
- Web-safe data transmission

## base64-url-decode

Decode URL-safe Base64 encoded strings.

### Usage

```bash
echo "aGVsbG8gd29ybGQ" | eoyc -e "base64-url-decode"
# Output: hello world
```

## Chaining with Base64

Base64 encoders work well in chains:

```bash
# Encode then hash
echo "data" | eoyc -e "base64>md5"

# Hash then encode
echo "data" | eoyc -e "sha256>base64"
```
