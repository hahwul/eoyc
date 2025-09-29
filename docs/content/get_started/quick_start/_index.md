+++
title = "Quick Start"
weight = 2
+++

# Quick Start Guide

Welcome to EOYC! This guide will get you up and running with basic encoding operations in minutes.

## Basic Usage

EOYC reads from stdin and applies encoding transformations to your input. The general syntax is:

```bash
echo "input" | eoyc [options]
```

## Your First Encoding

Let's start with a simple base64 encoding:

```bash
echo "hello world" | eoyc -e "base64"
# Output: aGVsbG8gd29ybGQ=
```

## Command-Line Options

- `-s STRING` - Encode a specific string within the input
- `-r REGEX` - Encode parts matching a regex pattern  
- `-e ENCODERS` - Specify encoder chain (the heart of EOYC!)
- `-o PATH` - Output to file (optional)

## Encoding Modes

### 1. Encode Entire Line (default)
```bash
echo "hello world" | eoyc -e "base64"
# Encodes: "hello world"
# Output: aGVsbG8gd29ybGQ=
```

### 2. Encode Specific String
```bash
echo "hello world" | eoyc -s "world" -e "base64"
# Encodes only: "world"
# Output: hello d29ybGQ=
```

### 3. Encode Regex Matches
```bash
echo "Contact: admin@example.com" | eoyc -r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" -e "sha1"
# Encodes the email part
# Output: Contact: w18pVtgE4B7y3sOS7zra42KJEj8=
```

## Encoder Chaining

One of EOYC's most powerful features is encoder chaining - apply multiple transformations in sequence:

```bash
echo "password123" | eoyc -e "base64>sha1"
# First applies base64, then SHA1 to the result
# Output: Y0s5Pa8spRGJJh+eM2sF+VZQ8ws=

echo "hello" | eoyc -e "url|upcase|md5"
# URL encode, then uppercase, then MD5
# Output: 4A2CB1D434746C2D8F2CFD70261A04DB
```

## Common Examples

### Hash a password
```bash
echo "mypassword" | eoyc -e "sha256"
# Output: 89e01536ac207279409d4de1e5253e01f4a1769e696db0d6062ca9b8f56767c8
```

### Encode for URL
```bash
echo "hello world!" | eoyc -e "url"
# Output: hello%20world%21
```

### Create a redacted version
```bash
echo "sensitive data" | eoyc -e "redacted"
# Output: █████████████
```

### Multiple file processing
```bash
cat urls.txt | eoyc -e "sha1"
# Each line gets SHA1 encoded
```

## What's Next?

- [Basic Usage](/usage/basic) - Learn all encoding options
- [Advanced Usage](/usage/advanced) - Complex patterns and techniques  
- [Encoder Reference](/encoders/overview) - Complete encoder documentation
- [Examples](/usage/examples) - Real-world use cases