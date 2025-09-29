+++
title = "Encoder Chaining"
weight = 2
+++

# Encoder Chaining

One of EOYC's most powerful features is the ability to chain multiple encoders together, creating complex transformation pipelines.

## Chain Syntax

You can use three different characters to chain encoders:
- `>` - Greater than
- `|` - Pipe  
- `,` - Comma

All three characters work identically:

```bash
# These are equivalent:
echo "hello" | eoyc -e "base64>md5"
echo "hello" | eoyc -e "base64|md5"  
echo "hello" | eoyc -e "base64,md5"
```

## How Chaining Works

Encoders are applied from **left to right**:

```bash
echo "password" | eoyc -e "base64>sha1"
# Step 1: "password" → base64 → "cGFzc3dvcmQ="
# Step 2: "cGFzc3dvcmQ=" → sha1 → "W6ph5Mm5Pz8GgiULbPgzG37mj9g="
```

## Common Chain Patterns

### Multi-Hash Chains
Create unique identifiers by combining different hash functions:

```bash
echo "data" | eoyc -e "md5>sha1"
echo "data" | eoyc -e "sha256>base64>md5"
```

### Encoding + Hashing
Perfect for creating safe, hashed representations:

```bash
echo "sensitive@email.com" | eoyc -e "base64>sha256"
echo "api-key-12345" | eoyc -e "url>md5"
```

### Text Transform Chains
Apply multiple text transformations:

```bash
echo "Hello World" | eoyc -e "downcase>reverse>upcase"
# hello world → dlrow olleh → DLROW OLLEH

echo "secret text" | eoyc -e "rot13>upcase>base64"
# frperg grkg → FRPERG GRKG → RlJDRVJHIEdSSEc=
```

### Complex Processing Chains
Combine encoding, transformation, and hashing:

```bash
echo "user@domain.com" | eoyc -e "url>upcase>md5>base64"
# URL encode → uppercase → MD5 hash → Base64 encode

echo "password123" | eoyc -e "reverse>sha256>hex>upcase"
# Reverse → SHA256 → hex → uppercase
```

## Real-World Examples

### Secure Password Processing
```bash
# Create a complex password hash
echo "mypassword" | eoyc -e "reverse>sha256>base64"

# Hash with salt-like preprocessing
echo "user:mypassword" | eoyc -s "mypassword" -e "upcase>sha256"
```

### Data Obfuscation
```bash
# Multi-layer data hiding
echo "sensitive info" | eoyc -e "base64>url>base64"

# Create redacted with hash reference
echo "credit card: 4111-1111-1111-1111" | eoyc -s "4111-1111-1111-1111" -e "sha1>redacted"
```

### Log Processing
```bash
# Hash and encode IP addresses
cat access.log | eoyc -r "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" -e "sha1>base64"

# Process API keys in logs
cat api.log | eoyc -r "apikey=[^&\s]+" -e "md5>hex>upcase"
```

### URL Processing
```bash
# Create safe URL identifiers
echo "https://long-url.example.com/path?params=values" | eoyc -e "sha1>base64>url"

# Clean and hash URLs
cat urls.txt | eoyc -e "downcase>url>md5"
```

## Chain Length Limits

- **No practical limit** on chain length
- **Performance impact** increases with chain length
- **Memory usage** is minimal for each encoder

```bash
# Long chain example (not recommended for production)
echo "test" | eoyc -e "base64>md5>hex>upcase>base64>sha1>downcase"
```

## Error Handling in Chains

When an encoder in a chain fails:
- The failed encoder is **skipped**
- Processing **continues** with the next encoder
- The result from the last successful encoder is used

```bash
# If 'invalid-encoder' doesn't exist, it's skipped
echo "hello" | eoyc -e "base64>invalid-encoder>md5"
# Result: MD5 of base64("hello")
```

## Performance Tips

1. **Order matters** - Place faster encoders first when possible
2. **Hash last** - Cryptographic functions are slower
3. **Test chains** - Verify results with sample data
4. **Avoid loops** - Don't encode/decode the same format repeatedly

```bash
# Efficient: fast transforms first
echo "data" | eoyc -e "upcase>reverse>md5"

# Less efficient: slow hash first  
echo "data" | eoyc -e "sha256>upcase>reverse"
```

## Debugging Chains

To debug complex chains, break them down step by step:

```bash
# Original chain
echo "test" | eoyc -e "base64>upcase>md5"

# Debug step by step:
echo "test" | eoyc -e "base64"                    # dGVzdA==
echo "test" | eoyc -e "base64>upcase"             # DGVZDA==
echo "test" | eoyc -e "base64>upcase>md5"         # Final result
```

## Best Practices

1. **Keep it simple** - Avoid overly complex chains
2. **Document purpose** - Comment complex chains in scripts
3. **Test thoroughly** - Verify with various inputs
4. **Consider alternatives** - Sometimes multiple commands are clearer

## Next Steps

- [Encoder Reference](/encoders/reference) - Complete encoder documentation
- [Advanced Usage](/usage/advanced) - Complex patterns and techniques
- [Examples](/usage/examples) - Real-world chaining scenarios