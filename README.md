# eoyc
Encoding Only Your Choices

## Installation
```bash
brew tap hahwul/eoyc
brew install eoyc
```

## Usage
```
Usage: eoyc [arguments]
    -a, --all                        Convert all string
    -s STRING, --string=STRING       Your choice string
    -r REGEX, --regex=REGEX          Your choice regex pattern
    -e ENCODERS, --encoders=ENCODERS Encoders chain [char: >|,]
    -o PATH, --output=PATH           Output file
    -v, --version                    Show version
    -h, --help                       Show help
```

First, choose the range that you want to encode:

- If you want to encode the entire line, use `-a`.
- If you want to encode a specific string, use `-s`.
- If you want to encode the part that matches a regular expression, use `-r`.

Second, choose the type of encoder you wish to run via `-e`. The encoder can consist of multiple chains.

> base64(base64-encode), base64-decode, md5, sha1, url(url-encode), url-decode, upcase, downcase, redacted

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
echo "abcdefghijk" | eoyc -a -e "md5>base64>sha1"
# 9EG0tX9wWhKDghHJECSS8E+XZ3U=
```

```bash
cat urls.txt | eoyc -a -e "sha1"
# uGDZ7JWU88EM8kFoGzIldEUtQc8=
# hLfkSqVNAC6sjQD1v6nMk0EPKkg=
# cv6VxVduxjTiFIFKMqt4VWjtp2o=
```

```bash
cat urls.txt | eoyc -a -e "url"   
# https%3A%2F%2Fwww.hahwul.com
# https%3A%2F%2Fgithub.com
# https%3A%2F%2Fgoogle.com
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