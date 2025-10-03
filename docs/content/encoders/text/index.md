---
title: "Text Transformations"
weight: 5
---

Text transformation encoders modify text in various ways without encoding to different formats.

## rot13

ROT13 (Rotate by 13 places) is a simple letter substitution cipher that replaces each letter with the letter 13 positions after it in the alphabet.

### Usage

```bash
echo "hello" | eoyc -e "rot13"
# Output: uryyb
```

### How It Works

- A-Z → N-ZA-M
- a-z → n-za-m
- Numbers and special characters remain unchanged

### Decoding

Apply ROT13 twice to get back the original:

```bash
echo "uryyb" | eoyc -e "rot13"
# Output: hello
```

### Examples

```bash
echo "secret message" | eoyc -e "rot13"
# Output: frperg zrffntr

echo "ROT13 Example" | eoyc -e "rot13"
# Output: EBG13 Rknzcyr
```

## upcase

Converts all text to uppercase.

### Usage

```bash
echo "hello world" | eoyc -e "upcase"
# Output: HELLO WORLD
```

### Examples

```bash
echo "test123" | eoyc -e "upcase"
# Output: TEST123

echo "Mixed Case Text" | eoyc -e "upcase"
# Output: MIXED CASE TEXT
```

## downcase

Converts all text to lowercase.

### Usage

```bash
echo "HELLO WORLD" | eoyc -e "downcase"
# Output: hello world
```

### Examples

```bash
echo "TEST123" | eoyc -e "downcase"
# Output: test123

echo "Mixed Case Text" | eoyc -e "downcase"
# Output: mixed case text
```

## reverse

Reverses the order of characters in the text.

### Usage

```bash
echo "hello" | eoyc -e "reverse"
# Output: olleh
```

### Examples

```bash
echo "Hello World" | eoyc -e "reverse"
# Output: dlroW olleH

echo "12345" | eoyc -e "reverse"
# Output: 54321
```

### Double Reverse

```bash
echo "test" | eoyc -e "reverse>reverse"
# Output: test (back to original)
```

## redacted

**Aliases:** `redaction`

Replaces all characters with block characters (◼) to redact sensitive information.

### Usage

```bash
echo "sensitive data" | eoyc -e "redacted"
# Output: ◼◼◼◼◼◼◼◼◼◼◼◼◼◼
```

### Examples

```bash
echo "password123" | eoyc -e "redacted"
# Output: ◼◼◼◼◼◼◼◼◼◼◼

echo "credit card: 1234-5678-9012-3456" | eoyc -s "1234-5678-9012-3456" -e "redacted"
# Output: credit card: ◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼◼
```

### Use Cases

- Log sanitization
- Data anonymization
- Privacy compliance
- Demo/screenshot preparation

## Combining Text Transformations

Text transformations work great in chains:

```bash
# Uppercase then reverse
echo "hello" | eoyc -e "upcase>reverse"
# Output: OLLEH

# ROT13 then uppercase
echo "secret" | eoyc -e "rot13>upcase"
# Output: FRPERG

# Reverse then ROT13
echo "test" | eoyc -e "reverse>rot13"
# Output: gfxr

# URL encode then uppercase
echo "test data" | eoyc -e "url>upcase"
# Output: TEST%20DATA
```

## Practical Examples

### Case Normalization

```bash
# Normalize emails to lowercase
cat emails.txt | eoyc -e "downcase"
```

### Obfuscation

```bash
# Simple obfuscation using ROT13
echo "hint" | eoyc -e "rot13"
```

### Data Sanitization

```bash
# Redact sensitive patterns
cat logs.txt | eoyc -r '\d{3}-\d{2}-\d{4}' -e "redacted"
```
