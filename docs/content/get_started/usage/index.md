---
title: "Usage"
weight: 2
---

Eoyc is a command-line tool for encoding and transforming text. It reads from STDIN and applies the specified encoders to your data.

## Basic Command Structure

```bash
eoyc [arguments]
```

## Command-Line Arguments

### `-s STRING, --string=STRING`
Your choice string to encode. When specified, only this exact string within each input line will be encoded.

```bash
echo "hello world" | eoyc -s "world" -e "base64"
# Output: hello d29ybGQ=
```

### `-r REGEX, --regex=REGEX`
Your choice regex pattern. When specified, only the part matching the regex will be encoded.

```bash
echo "email: user@example.com" | eoyc -r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" -e "sha1"
# Output: email: w18pVtgE4B7y3sOS7zra42KJEj8=
```

### `-e ENCODERS, --encoders=ENCODERS`
Encoders chain. You can use `>`, `|`, or `,` characters to chain multiple encoders together.

```bash
# Single encoder
echo "test" | eoyc -e "base64"
# Output: dGVzdA==

# Multiple encoders chained
echo "test" | eoyc -e "base64>md5"
# Output: 65682a9301ce243d376d9b26b0b2c3bb

# Alternative chain characters
echo "test" | eoyc -e "url|upcase|md5"
echo "test" | eoyc -e "url>upcase,md5"
```

### `-o PATH, --output=PATH`
Output file path (currently supported as a flag).

### `-v, --version`
Show version information.

```bash
eoyc --version
# Output: 0.2.0
```

### `-h, --help`
Show help information including all available encoders.

```bash
eoyc --help
```

## Encoding Modes

### 1. Full Line Encoding (Default)

By default, the entire line is encoded:

```bash
echo "abcdefghijk" | eoyc -e "md5"
# Output: 06c48e7ea982782c827c8b15fc8c793d
```

### 2. String Selection Mode (`-s`)

Encode only a specific substring:

```bash
echo "abcdefghijk" | eoyc -s "bcde" -e "base64"
# Output: aYmNkZWZnaGlqaw==
```

### 3. Regex Pattern Mode (`-r`)

Encode only the part that matches a regular expression:

```bash
echo "https://www.example.com" | eoyc -r "https?://[^\s]+" -e "url"
# Output: https%3A%2F%2Fwww.example.com
```

## Chaining Encoders

One of the most powerful features of eoyc is the ability to chain multiple encoders together. The encoders are applied in the order specified:

```bash
# Apply base64, then md5, then sha1
echo "test" | eoyc -e "base64>md5>sha1"

# Apply URL encoding, then convert to uppercase, then MD5
echo "test data" | eoyc -e "url>upcase>md5"
```

You can use any of these characters to separate encoders in a chain:
- `>` (greater than)
- `|` (pipe)
- `,` (comma)

## Working with Files

Eoyc reads from STDIN, so you can easily process files:

```bash
# Process a file line by line
cat urls.txt | eoyc -e "sha1"

# Process and save to output file
cat data.txt | eoyc -e "base64" > encoded.txt
```

## Next Steps

- Check out [Examples](/get_started/examples) for more use cases
- Browse the [Encoders Reference](/encoders) for all available encoders
