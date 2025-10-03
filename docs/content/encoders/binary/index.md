---
title: "Binary & Character Encoders"
weight: 6
---

These encoders convert text to various numeric and binary representations.

## bin

**Aliases:** `bin-encode`

Encodes text to 8-bit binary representation with spaces between bytes.

### Usage

```bash
echo "abc" | eoyc -e "bin"
# Output: 01100001 01100010 01100011
```

### How It Works

Each character is converted to its 8-bit binary representation:
- 'a' (97) → 01100001
- 'b' (98) → 01100010
- 'c' (99) → 01100011

### Examples

```bash
echo "A" | eoyc -e "bin"
# Output: 01000001

echo "hello" | eoyc -e "bin"
# Output: 01101000 01100101 01101100 01101100 01101111
```

## bin-decode

Decodes binary strings back to text.

### Usage

```bash
echo "01100001 01100010 01100011" | eoyc -e "bin-decode"
# Output: abc
```

### Examples

```bash
echo "01000001" | eoyc -e "bin-decode"
# Output: A

echo "01101000 01100101 01101100 01101100 01101111" | eoyc -e "bin-decode"
# Output: hello
```

## oct

**Aliases:** `oct-encode`

Encodes text to octal (base 8) representation.

### Usage

```bash
echo "abc" | eoyc -e "oct"
# Output: 141142143
```

### How It Works

Each character is converted to its octal ASCII value:
- 'a' (97) → 141 (octal)
- 'b' (98) → 142 (octal)
- 'c' (99) → 143 (octal)

### Examples

```bash
echo "A" | eoyc -e "oct"
# Output: 101

echo "hello" | eoyc -e "oct"
# Output: 150145154154157
```

## oct-decode

Decodes octal strings back to text.

### Usage

```bash
echo "141142143" | eoyc -e "oct-decode"
# Output: abc
```

### Examples

```bash
echo "101" | eoyc -e "oct-decode"
# Output: A

echo "150145154154157" | eoyc -e "oct-decode"
# Output: hello
```

## unicode

**Aliases:** `unicode-encode`

Encodes text to Unicode escape sequences in the format `\uXXXX`.

### Usage

```bash
echo "hello" | eoyc -e "unicode"
# Output: \u0068\u0065\u006c\u006c\u006f
```

### Examples

```bash
echo "A" | eoyc -e "unicode"
# Output: \u0041

echo "@" | eoyc -e "unicode"
# Output: \u0040

echo "abc" | eoyc -e "unicode"
# Output: \u0061\u0062\u0063
```

### Use Cases

- JavaScript/JSON string escaping
- Unicode character representation
- Cross-platform text encoding

## unicode-decode

Decodes Unicode escape sequences back to text.

### Usage

```bash
echo "\\u0068\\u0065\\u006c\\u006c\\u006f" | eoyc -e "unicode-decode"
# Output: hello
```

Note: The backslashes need to be escaped in shell.

### Examples

```bash
echo "\\u0041" | eoyc -e "unicode-decode"
# Output: A

echo "\\u0061\\u0062\\u0063" | eoyc -e "unicode-decode"
# Output: abc
```

## charcode

**Aliases:** `charcode-encode`

Encodes text to decimal ASCII/character code values separated by spaces.

### Usage

```bash
echo "abc" | eoyc -e "charcode"
# Output: 97 98 99
```

### How It Works

Each character is converted to its decimal ASCII value:
- 'a' → 97
- 'b' → 98
- 'c' → 99

### Examples

```bash
echo "A" | eoyc -e "charcode"
# Output: 65

echo "hello" | eoyc -e "charcode"
# Output: 104 101 108 108 111

echo "123" | eoyc -e "charcode"
# Output: 49 50 51
```

## charcode-decode

Decodes character code values back to text.

### Usage

```bash
echo "97 98 99" | eoyc -e "charcode-decode"
# Output: abc
```

### Examples

```bash
echo "65" | eoyc -e "charcode-decode"
# Output: A

echo "104 101 108 108 111" | eoyc -e "charcode-decode"
# Output: hello
```

## Round-Trip Examples

All encoding/decoding pairs support round-trip conversion:

```bash
# Binary
echo "test" | eoyc -e "bin" | eoyc -e "bin-decode"
# Output: test

# Octal
echo "test" | eoyc -e "oct" | eoyc -e "oct-decode"
# Output: test

# Unicode
echo "test" | eoyc -e "unicode" | eoyc -e "unicode-decode"
# Output: test

# Character codes
echo "test" | eoyc -e "charcode" | eoyc -e "charcode-decode"
# Output: test
```

## Use Cases

### Binary Encoding
- Low-level data inspection
- Educational purposes
- Binary data visualization

### Octal Encoding
- Unix file permissions representation
- Legacy system compatibility

### Unicode Encoding
- JavaScript string escaping
- JSON data encoding
- Cross-platform character handling

### Character Code Encoding
- ASCII value inspection
- Protocol development
- Data analysis

## Chaining Examples

```bash
# Character codes to hex
echo "abc" | eoyc -e "charcode>hex"

# Binary to base64
echo "test" | eoyc -e "bin>base64"

# Octal to MD5
echo "test" | eoyc -e "oct>md5"
```
