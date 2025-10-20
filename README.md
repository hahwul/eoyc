# eoyc
Encoding Only Your Choices

## Documentation

For comprehensive documentation, visit: [https://eoyc.hahwul.com](https://eoyc.hahwul.com)

Or view the documentation locally:
```bash
cd docs
zola serve
```

## Installation
```bash
brew tap hahwul/eoyc
brew install eoyc
```

## Usage
```
Usage: eoyc [arguments]
    -s STRING, --string=STRING       Your choice string
    -r REGEX, --regex=REGEX          Your choice regex pattern
    -e ENCODERS, --encoders=ENCODERS Encoders chain [char: >|,]
    -o PATH, --output=PATH           Output file
    -v, --version                    Show version
    -l, --list                       List encoders
    -h, --help                       Show help

Encoders:
  base64            - Base64 encode (aliases: base64-encode)
  base64-decode     - Base64 decode
  base64-url        - URL-safe Base64 encode (no padding) (aliases: base64-url-encode)
  base64-url-decode - URL-safe Base64 decode
  base64-url-pad    - URL-safe Base64 encode (with padding) (aliases: base64-url-encode-pad)
  base64-url-pad-decode - URL-safe Base64 decode (accepts padding)
  base32            - Base32 encode (RFC 4648, with padding) (aliases: base32-encode)
  base32-decode     - Base32 decode (RFC 4648)
  crc32             - CRC32 hex digest (IEEE 802.3) (aliases: crc32-hex)
  md5               - MD5 hex digest
  sha1              - SHA1 Base64 digest
  sha1-hex          - SHA1 hex digest
  sha256            - SHA256 Base64 digest
  sha256-hex        - SHA256 hex digest
  sha512            - SHA512 Base64 digest
  sha512-hex        - SHA512 hex digest
  hex               - Hex (lowercase) encode (aliases: hex-encode)
  hex-decode        - Hex decode
  url               - application/x-www-form-urlencoded encode (aliases: url-encode)
  url-decode        - application/x-www-form-urlencoded decode
  rot13             - ROT13 substitution cipher
  upcase            - Uppercase transform
  downcase          - Lowercase transform
  reverse           - Reverse text
  redacted          - Replace all characters with blocks (aliases: redaction)
  bin               - Binary (8-bit) encode with spaces (aliases: bin-encode)
  bin-decode        - Binary decode
  oct               - Octal (base 8) encode (aliases: oct-encode)
  oct-decode        - Octal decode
  unicode           - Unicode encode (aliases: unicode-encode)
  unicode-decode    - Unicode decode
  charcode          - Character code encode (decimal ASCII values with spaces) (aliases: charcode-encode)
  charcode-decode   - Character code decode
```

First, choose the range that you want to encode:

- By default, the entire line is encoded.
- If you want to encode a specific string, use `-s`.
- If you want to encode the part that matches a regular expression, use `-r`. Lines that do not match are passed through unchanged.

Second, choose the type of encoder you wish to run via `-e`. The encoder can consist of multiple chains.

```bash
# Encoder chanins
# You can use '>' and '|' and ',' characters for chain.
-e "base64"
-e "base64>md5"
-e "url|upcase|md5"
-e "url>upcase,md5"
```

## Examples
```bash
echo "abcdefghijk" | eoyc -s bcde -e "md5>base64>sha1"
# aCFV4rFRO+h/0cCngUl1Ccahz040=fghijk
```

```bash
echo "abcdefghijk" | eoyc -e "md5>base64>sha1"
# 9EG0tX9wWhKDghHJECSS8E+XZ3U=
```

```bash
cat urls.txt | eoyc -e "sha1"
# uGDZ7JWU88EM8kFoGzIldEUtQc8=
# hLfkSqVNAC6sjQD1v6nMk0EPKkg=
# cv6VxVduxjTiFIFKMqt4VWjtp2o=
```

```bash
cat urls.txt | eoyc -e "url"
# https%3A%2F%2Fwww.hahwul.com
# https%3A%2F%2Fgithub.com
# https%3A%2F%2Fgoogle.com
```

```bash
# Save to output file (no shell redirection needed)
cat data.txt | eoyc -e "base64" -o encoded.txt
# Note: the output file is overwritten on each run
```

```bash
# Regex no-match pass-through
echo "no digits here" | eoyc -r "\\d+" -e "base64"
# no digits here

# Regex match example
echo "user: alice, id: 42" | eoyc -r "\\d+" -e "hex"
# user: alice, id: 3432
```

## Build
```bash
# Clone github repo
git clone https://github.com/hahwul/eoyc
cd eoyc

# Build eoyc
shards install
shards build

# Run
./bin/eoyc -h
```

## Test
```bash
crystal spec -v
```
