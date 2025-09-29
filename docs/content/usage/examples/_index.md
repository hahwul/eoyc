+++
title = "Examples"
weight = 3
+++

# Usage Examples

Real-world examples of using EOYC for various tasks.

## Security & Privacy

### Password Processing
```bash
# Hash passwords securely
echo "mypassword123" | eoyc -e "sha256"
# Output: ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f

# Create salted password hash
echo "user123:password" | eoyc -s "password" -e "sha256"
# Output: user123:5994471abb01112afcc18159f6cc74b4f511b99806da59b3caf5a9c173cacfc5

# Multi-layer password obfuscation
echo "admin:secret123" | eoyc -s "secret123" -e "reverse>base64>sha1"
```

### Data Redaction
```bash
# Redact sensitive data in logs
echo "User SSN: 123-45-6789" | eoyc -s "123-45-6789" -e "redacted"
# Output: User SSN: ███████████

# Redact credit card numbers
echo "Card: 4111-1111-1111-1111" | eoyc -r "\d{4}-\d{4}-\d{4}-\d{4}" -e "redacted"
# Output: Card: ███████████████████

# Redact emails with hash reference
echo "Contact admin@company.com" | eoyc -r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}" -e "sha1"
# Output: Contact w18pVtgE4B7y3sOS7zra42KJEj8=
```

## Web Development

### URL Processing
```bash
# URL encode parameters
echo "search query with spaces" | eoyc -e "url"
# Output: search%20query%20with%20spaces

# Create safe URL slugs
echo "My Blog Post Title!" | eoyc -e "downcase>url"
# Output: my%20blog%20post%20title%21

# Hash URLs for analytics
cat urls.txt | eoyc -e "sha1"
```

### API Key Management
```bash
# Hash API keys for logging
echo "API-KEY-ABC123XYZ789" | eoyc -e "sha256>base64"

# Redact API keys in config files
cat config.yaml | eoyc -r "api[_-]?key:\s*[A-Za-z0-9]+" -e "redacted"

# Generate API key hashes for comparison
echo "user-api-key-value" | eoyc -e "sha256>hex>upcase"
```

## DevOps & System Administration

### Log Processing
```bash
# Hash IP addresses in Apache logs
cat access.log | eoyc -r "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" -e "sha1"

# Process nginx error logs
cat error.log | eoyc -r "client:\s*[\d\.]+" -e "sha256>base64"

# Redact user agents
cat access.log | eoyc -r '"[^"]*Mozilla[^"]*"' -e "redacted"
```

### Configuration Management
```bash
# Hash database passwords in configs
cat database.conf | eoyc -r "password=[^\\s]+" -e "sha256"

# Encode sensitive environment variables
echo "DATABASE_URL=postgres://user:pass@host/db" | eoyc -s "user:pass" -e "base64"

# Create config file checksums
cat important.conf | eoyc -e "sha256>hex"
```

### Docker & Kubernetes
```bash
# Hash container environment secrets
kubectl get secret mysecret -o yaml | eoyc -r "password:\s*[A-Za-z0-9+/]+=*" -e "sha256"

# Create unique deployment identifiers
echo "myapp-v1.2.3-production" | eoyc -e "sha1>base64>url"
```

## Data Processing

### File Processing
```bash
# Create file content hashes
find . -name "*.txt" -exec sh -c 'echo "$1: $(cat "$1" | eoyc -e "sha256")"' _ {} \;

# Process CSV data
cat users.csv | eoyc -r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}" -e "sha1"

# Bulk URL encoding
cat url-list.txt | eoyc -e "url" > encoded-urls.txt
```

### Database Operations
```bash
# Generate user ID hashes
echo "john.doe@company.com" | eoyc -e "sha256>hex" | cut -c1-16

# Create password reset tokens
echo "user123:$(date +%s)" | eoyc -e "sha256>base64>url"

# Hash sensitive database exports
mysqldump mydb | eoyc -r "\b[0-9]{4}-[0-9]{4}-[0-9]{4}-[0-9]{4}\b" -e "redacted"
```

## Network Security

### Penetration Testing
```bash
# Encode payloads
echo "<script>alert('xss')</script>" | eoyc -e "url"
echo "' OR 1=1 --" | eoyc -e "base64"

# Create unique session identifiers
echo "user123:$(date):random" | eoyc -e "sha256>base64"

# Hash discovered subdomains
cat subdomains.txt | eoyc -e "sha1" | sort | uniq
```

### Incident Response
```bash
# Hash indicators of compromise
cat iocs.txt | eoyc -e "sha256>hex>upcase"

# Redact sensitive information in reports
cat incident-report.txt | eoyc -r "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" -e "redacted"

# Create anonymized log exports
cat security.log | eoyc -r "user=[^\\s]+" -e "sha1"
```

## Content Management

### Blog & CMS
```bash
# Create SEO-friendly slugs
echo "My Amazing Blog Post Title" | eoyc -e "downcase>url"

# Generate content hashes for caching
cat article.html | eoyc -e "sha256>base64"

# Anonymize user comments
cat comments.xml | eoyc -r "email=\"[^\"]+\"" -e "sha1"
```

### Media Processing
```bash
# Create unique filenames
echo "vacation-photo.jpg" | eoyc -e "sha1>base64" | tr '/' '_'

# Hash media metadata
exiftool image.jpg | eoyc -r "GPS.*" -e "redacted"
```

## Advanced Patterns

### Complex Chaining
```bash
# Multi-stage data transformation
echo "sensitive-data-2023" | eoyc -e "upcase>rot13>base64>sha1>hex"

# Layered encoding for secure transmission
echo "secret message" | eoyc -e "base64>url>base64>sha256"

# Create unique identifiers with multiple inputs
echo "user:john:session:$(date +%s)" | eoyc -e "sha256>base64>url"
```

### Pipeline Integration
```bash
# Combine with other tools
curl -s https://api.example.com/users | jq -r '.email' | eoyc -e "sha1"

# Process streaming data
tail -f app.log | grep "ERROR" | eoyc -r "user=[^\\s]+" -e "sha256"

# Batch processing with xargs
cat email-list.txt | xargs -I {} sh -c 'echo "{}: $(echo {} | eoyc -e "sha1")"'
```

## Performance Examples

### Large File Processing
```bash
# Efficient large file hashing
cat large-file.txt | eoyc -e "sha256" > checksum.txt

# Streaming log processing
tail -f massive.log | eoyc -r "sensitive-pattern" -e "redacted"

# Parallel processing
split -l 1000 huge-dataset.txt chunk-
ls chunk-* | xargs -P 4 -I {} sh -c 'eoyc -e "sha1" < {} > {}.hash'
```

## Error Handling Examples

### Graceful Degradation
```bash
# Continue processing even with invalid encoders
echo "test" | eoyc -e "base64>invalid>md5"  # Still produces output

# Handle malformed input gracefully
echo "invalid-base64" | eoyc -e "base64-decode"  # Returns original
```

These examples demonstrate EOYC's versatility across different domains and use cases. The key is understanding how to combine the right encoders for your specific needs.