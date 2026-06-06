# eoyc
Endless Options, Your Chain

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
```

Run `eoyc -l` (or `--list`) to see all available encoders (57+).  
Use `--list-json`, `--describe=NAME`, `--search=KEYWORD`, `--categories`, or `--capabilities` for discovery.

Direct invocation (no pipe required):

```
eoyc -e base64 hello
eoyc -e 'sha256-hex' "some text"
eoyc -e 'base64>hex' foo bar
```

First, choose the range that you want to encode:

- By default, the entire line is encoded.
- If you want to encode a specific string, use `-s`.
- If you want to encode the part that matches a regular expression, use `-r`. Lines that do not match are passed through unchanged.

Second, choose the type of encoder you wish to run via `-e`. The encoder can consist of multiple chains.

```bash
# Encoder chains
# You can use '>' , '|' or ',' characters for chaining (left to right application).
-e "base64"
-e "base64>md5"
-e "url|upcase|md5"
-e "url>upcase,md5"

# Direct (no stdin pipe)
eoyc -e "base64>hex" hello
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
