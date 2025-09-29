+++
title = "Advanced Usage"
weight = 2
+++

# Advanced Usage

Advanced patterns and techniques for power users of EOYC.

## Complex Regex Patterns

### Email Processing
```bash
# Standard email regex
echo "Contact us at admin@example.com" | eoyc -r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" -e "sha1"

# More comprehensive email regex
echo "Send to test.email+tag@sub.domain.co.uk" | eoyc -r "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b" -e "redacted"
```

### URL Processing
```bash
# HTTP/HTTPS URLs
echo "Visit https://example.com/path?param=value" | eoyc -r "https?://[^\s]+" -e "sha256"

# URLs with authentication
echo "https://user:pass@example.com/path" | eoyc -r "https?://[^:]+:[^@]+@[^\s]+" -e "redacted"
```

### Data Extraction
```bash
# IP addresses
cat logs.txt | eoyc -r "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" -e "sha1"

# Credit card numbers
cat transactions.txt | eoyc -r "\b\d{4}[-\s]?\d{4}[-\s]?\d{4}[-\s]?\d{4}\b" -e "redacted"

# Social Security Numbers
cat records.txt | eoyc -r "\b\d{3}-\d{2}-\d{4}\b" -e "sha256"
```

## Performance Optimization

### Large File Processing
```bash
# Stream processing for large files
tail -f huge-log.txt | eoyc -r "sensitive-pattern" -e "redacted"

# Parallel processing with xargs
cat large-dataset.txt | split -l 1000 - chunk-
ls chunk-* | xargs -P 4 -I {} sh -c 'eoyc -e "sha1" < {} > {}.hash'
```

### Memory-Efficient Processing
```bash
# Process one line at a time for very large files
while IFS= read -r line; do
  echo "$line" | eoyc -r "pattern" -e "sha256"
done < massive-file.txt
```

## Integration Patterns

### CI/CD Pipelines
```bash
# Sanitize environment variables in build logs
env | eoyc -r "PASSWORD.*=.*" -e "redacted"
env | eoyc -r "TOKEN.*=.*" -e "redacted"

# Create deployment checksums
git rev-parse HEAD | eoyc -e "sha256>base64" > deployment.checksum
```

### Monitoring and Alerting
```bash
# Hash sensitive data in monitoring
curl -s https://api.service.com/health | jq -r '.database_connection' | eoyc -e "sha256"

# Create anonymized alert identifiers
echo "server-01:disk-full:$(date +%s)" | eoyc -e "sha1>base64"
```

### Database Operations
```bash
# Generate user ID hashes for anonymization
mysql -e "SELECT email FROM users" | tail -n +2 | eoyc -e "sha256" | head -20

# Create session tokens
echo "user123:$(date +%s):$(openssl rand -hex 16)" | eoyc -e "sha256>base64>url"
```

## Error Handling and Recovery

### Graceful Degradation
```bash
# Continue processing even with invalid encoders
echo "test" | eoyc -e "base64>invalid-encoder>md5"
# Result: MD5 hash of base64 encoded "test"

# Handle malformed input
echo "invalid-base64-===" | eoyc -e "base64-decode"
# Result: original string returned unchanged
```

### Validation Patterns
```bash
# Validate input before processing
if echo "$input" | grep -q "valid-pattern"; then
  echo "$input" | eoyc -e "sha256"
else
  echo "Invalid input: $input"
fi
```

## Security Considerations

### Safe Regex Patterns
- Always test regex patterns with sample data
- Avoid overly broad patterns that might match unintended content
- Use word boundaries (`\b`) to prevent partial matches

### Data Sanitization
```bash
# Remove metadata before hashing
echo "sensitive data with timestamp $(date)" | sed 's/[0-9-]* [0-9:]*//g' | eoyc -e "sha256"

# Normalize data before processing
echo "  Mixed Case Email@DOMAIN.COM  " | tr '[:upper:]' '[:lower:]' | xargs | eoyc -e "sha1"
```

### Audit Trail
```bash
# Log original and encoded values for audit
echo "Original: $data, Hash: $(echo $data | eoyc -e "sha256")" >> audit.log
```

## Debugging Complex Operations

### Step-by-step Chain Analysis
```bash
# Break down complex chains
original="test data"
step1=$(echo "$original" | eoyc -e "base64")
step2=$(echo "$step1" | eoyc -e "upcase")  
step3=$(echo "$step2" | eoyc -e "md5")

echo "Original: $original"
echo "Step 1 (base64): $step1"
echo "Step 2 (upcase): $step2"
echo "Step 3 (md5): $step3"
```

### Validation Scripts
```bash
#!/bin/bash
# Validate encoder chains
test_input="hello world"
expected_output="expected_hash_value"

actual_output=$(echo "$test_input" | eoyc -e "your-chain-here")

if [ "$actual_output" = "$expected_output" ]; then
  echo "✓ Chain validation passed"
else
  echo "✗ Chain validation failed"
  echo "Expected: $expected_output"
  echo "Actual: $actual_output"
fi
```

## Best Practices Summary

1. **Test First** - Always validate patterns with sample data
2. **Document Complex Chains** - Comment your encoder chains
3. **Handle Errors Gracefully** - Account for invalid input
4. **Consider Performance** - Profile large-scale operations
5. **Maintain Security** - Follow security best practices
6. **Create Audit Trails** - Log important operations
7. **Use Version Control** - Track changes to processing scripts

## Next Steps

- [Examples](/usage/examples) - Real-world usage scenarios
- [Encoder Reference](/encoders/reference) - Complete encoder documentation
- [Contributing](/contributing) - Help improve EOYC