---
title: "Examples"
weight: 3
---

Here are practical examples of using eoyc in various scenarios.

## Basic Encoding

### Single Encoder

Encode a simple string with Base64:

```bash
echo "test" | eoyc -e "base64"
# Output: dGVzdA==
```

Hash a string with SHA1:

```bash
echo "password123" | eoyc -e "sha1"
# Output: c29tZS1oYXNoLXZhbHVl
```

### URL Encoding

Encode URLs for safe transmission:

```bash
cat urls.txt | eoyc -e "url"
# Input:
# https://www.hahwul.com
# https://github.com
# https://google.com

# Output:
# https%3A%2F%2Fwww.hahwul.com
# https%3A%2F%2Fgithub.com
# https%3A%2F%2Fgoogle.com
```

## Chain Encoding

### Base64 and MD5 Chain

Apply multiple encodings in sequence:

```bash
echo "abcdefghijk" | eoyc -e "base64>md5"
# First applies base64, then MD5 to the result
```

### Complex Chain with String Selection

Encode a specific substring through multiple transformations:

```bash
echo "abcdefghijk" | eoyc -s bcde -e "md5>base64>sha1"
# Output: aCFV4rFRO+h/0cCngUl1Ccahz040=fghijk
# Only "bcde" is encoded through the chain
```

### Full Line Chain Encoding

Process the entire line through a chain:

```bash
echo "abcdefghijk" | eoyc -e "md5>base64>sha1"
# Output: 9EG0tX9wWhKDghHJECSS8E+XZ3U=
```

## Pattern Matching with Regex

### Email Obfuscation

Hash email addresses in text:

```bash
echo "Contact: user@example.com for info" | eoyc -r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" -e "sha1"
# Output: Contact: w18pVtgE4B7y3sOS7zra42KJEj8= for info
```

### URL Pattern Matching

Encode only URLs in a line:

```bash
echo "Visit https://www.example.com for details" | eoyc -r "https?://[^\s]+" -e "url"
# Output: Visit https%3A%2F%2Fwww.example.com for details
```

## Text Transformations

### Case Transformations

```bash
echo "Hello World" | eoyc -e "upcase"
# Output: HELLO WORLD

echo "Hello World" | eoyc -e "downcase"
# Output: hello world
```

### ROT13 Cipher

```bash
echo "secret message" | eoyc -e "rot13"
# Output: frperg zrffntr

# Decode by applying ROT13 again
echo "frperg zrffntr" | eoyc -e "rot13"
# Output: secret message
```

### Text Reversal

```bash
echo "Hello World" | eoyc -e "reverse"
# Output: dlroW olleH
```

### Redaction

```bash
echo "sensitive data" | eoyc -e "redacted"
# Output: ◼◼◼◼◼◼◼◼◼◼◼◼◼◼
```

## Binary and Character Encodings

### Binary Encoding

```bash
echo "abc" | eoyc -e "bin"
# Output: 01100001 01100010 01100011

# Decode
echo "01100001 01100010 01100011" | eoyc -e "bin-decode"
# Output: abc
```

### Octal Encoding

```bash
echo "abc" | eoyc -e "oct"
# Output: 141142143

# Decode
echo "141142143" | eoyc -e "oct-decode"
# Output: abc
```

### Unicode Encoding

```bash
echo "hello" | eoyc -e "unicode"
# Output: \u0068\u0065\u006c\u006c\u006f

# Decode
echo "\\u0068\\u0065\\u006c\\u006c\\u006f" | eoyc -e "unicode-decode"
# Output: hello
```

### Character Code (ASCII Values)

```bash
echo "abc" | eoyc -e "charcode"
# Output: 97 98 99

# Decode
echo "97 98 99" | eoyc -e "charcode-decode"
# Output: abc
```

## Hex Encoding

```bash
echo "hello" | eoyc -e "hex"
# Output: 68656c6c6f

# Decode
echo "68656c6c6f" | eoyc -e "hex-decode"
# Output: hello
```

## Batch Processing

### Processing Multiple Files

```bash
for file in *.txt; do
    cat "$file" | eoyc -e "sha256" > "${file}.encoded"
done
```

### Pipeline Integration

```bash
# Extract URLs from HTML and encode them
cat page.html | grep -oP 'https?://[^\s<>"]+' | eoyc -e "url"
```

### Combining with Other Tools

```bash
# Find unique encoded values
cat data.txt | eoyc -e "sha1" | sort | uniq

# Count encoded values
cat urls.txt | eoyc -e "md5" | wc -l
```

## Advanced Use Cases

### Security Testing

Prepare payloads with various encodings:

```bash
echo "<script>alert('xss')</script>" | eoyc -e "url>base64"
```

### Data Anonymization

Hash sensitive information in logs:

```bash
cat access.log | eoyc -r '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' -e "sha256"
```

### Configuration Obfuscation

```bash
echo "api_key=secret123" | eoyc -s "secret123" -e "base64>rot13"
```

## Next Steps

- Explore all available [Encoders](/encoders) and their options
- Check the [Usage](/get_started/usage) guide for detailed parameter descriptions
