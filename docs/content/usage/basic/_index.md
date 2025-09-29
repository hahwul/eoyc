+++
title = "Basic Usage"
weight = 1
+++

# Basic Usage

EOYC provides flexible string encoding and transformation capabilities through a simple command-line interface.

## Command Syntax

```bash
eoyc [arguments]
    -s STRING, --string=STRING       Your choice string
    -r REGEX, --regex=REGEX          Your choice regex pattern
    -e ENCODERS, --encoders=ENCODERS Encoders chain [char: >|,]
    -o PATH, --output=PATH           Output file
    -v, --version                    Show version
    -h, --help                       Show help
```

## Input Methods

### Standard Input (Default)
EOYC reads from stdin by default, making it perfect for pipes:

```bash
echo "hello world" | eoyc -e "base64"
cat file.txt | eoyc -e "sha1"
curl -s https://example.com | eoyc -e "md5"
```

### String Selection (-s)
Encode only specific strings within the input:

```bash
echo "The password is secret123" | eoyc -s "secret123" -e "sha256"
# Output: The password is e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
```

### Regex Pattern Matching (-r)
Use regex to select what gets encoded:

```bash
# Encode email addresses
echo "Contact: admin@example.com or support@company.org" | eoyc -r "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" -e "sha1"

# Encode URLs
echo "Visit https://example.com or http://test.org" | eoyc -r "https?://[^\s]+" -e "base64"

# Encode phone numbers
echo "Call us at 555-123-4567 or 555-987-6543" | eoyc -r "\d{3}-\d{3}-\d{4}" -e "redacted"
```

## Encoder Selection (-e)

### Single Encoder
```bash
echo "hello" | eoyc -e "base64"    # Base64 encoding
echo "hello" | eoyc -e "md5"       # MD5 hash
echo "hello" | eoyc -e "url"       # URL encoding
echo "hello" | eoyc -e "upcase"    # Uppercase
```

### Multiple Files
Process multiple files or lines:

```bash
# URLs from file
cat urls.txt | eoyc -e "sha1"

# Multiple lines of input
printf "line1\nline2\nline3" | eoyc -e "base64"
```

## Output Options

### Console Output (Default)
By default, EOYC outputs to stdout:

```bash
echo "hello" | eoyc -e "base64"
# Outputs to console
```

### File Output (-o)
Save results to a file:

```bash
echo "hello" | eoyc -e "base64" -o encoded.txt
cat input.txt | eoyc -e "sha1" -o hashes.txt
```

## Common Patterns

### Password Hashing
```bash
echo "mypassword" | eoyc -e "sha256"
echo "admin:password123" | eoyc -s "password123" -e "sha256"
```

### Data Obfuscation
```bash
echo "sensitive information" | eoyc -e "redacted"
echo "API key: abc123xyz" | eoyc -s "abc123xyz" -e "redacted"
```

### URL Processing
```bash
echo "https://example.com/path?param=value" | eoyc -e "url"
cat urls.txt | eoyc -e "base64" | sort | uniq
```

### Log Processing
```bash
# Hash IP addresses in logs
cat access.log | eoyc -r "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" -e "sha1"

# Encode sensitive parameters
cat api.log | eoyc -r "apikey=[^&\s]+" -e "redacted"
```

## Tips and Best Practices

1. **Test regex patterns** - Use tools like regex101.com to validate patterns before using them
2. **Pipe-friendly** - EOYC works great in command pipelines
3. **Performance** - For large files, consider processing in chunks
4. **Validation** - Always test transformations with sample data first

## Next Steps

- [Advanced Usage](/usage/advanced) - Complex encoder chaining and patterns
- [Examples](/usage/examples) - Real-world usage scenarios  
- [Encoder Reference](/encoders/overview) - Complete list of available encoders