---
title: "URL Encoders"
weight: 4
---

URL encoding (also called percent-encoding) converts characters into a format that can be transmitted over the Internet.

## url

**Aliases:** `url-encode`

Encodes text using application/x-www-form-urlencoded format. Special characters are converted to `%XX` format where XX is the hexadecimal value.

### Usage

```bash
echo "hello world" | eoyc -e "url"
# Output: hello%20world
```

### Characters That Are Encoded

- Space → `%20`
- `!` → `%21`
- `#` → `%23`
- `$` → `%24`
- `&` → `%26`
- `'` → `%27`
- `(` → `%28`
- `)` → `%29`
- `*` → `%2A`
- `+` → `%2B`
- `,` → `%2C`
- `/` → `%2F`
- `:` → `%3A`
- `;` → `%3B`
- `=` → `%3D`
- `?` → `%3F`
- `@` → `%40`
- `[` → `%5B`
- `]` → `%5D`

### Examples

```bash
echo "https://example.com/path?name=value" | eoyc -e "url"
# Output: https%3A%2F%2Fexample.com%2Fpath%3Fname%3Dvalue

echo "user@example.com" | eoyc -e "url"
# Output: user%40example.com

echo "hello world & goodbye" | eoyc -e "url"
# Output: hello%20world%20%26%20goodbye
```

## url-decode

Decodes URL-encoded strings back to original text.

### Usage

```bash
echo "hello%20world" | eoyc -e "url-decode"
# Output: hello world
```

### Examples

```bash
echo "https%3A%2F%2Fexample.com" | eoyc -e "url-decode"
# Output: https://example.com

echo "user%40example.com" | eoyc -e "url-decode"
# Output: user@example.com
```

## Round-Trip Example

```bash
echo "Special chars: !@#$%^&*()" | eoyc -e "url" | eoyc -e "url-decode"
# Output: Special chars: !@#$%^&*()
```

## Use Cases

- Preparing data for HTTP GET parameters
- Encoding email addresses and special characters in URLs
- Form data submission
- API query parameters

### Practical Example: URL Processing

```bash
# Encode URLs from a file
cat urls.txt | eoyc -e "url"

# Encode only the URL part in a line
echo "Visit https://www.example.com for info" | eoyc -r "https?://[^\s]+" -e "url"
# Output: Visit https%3A%2F%2Fwww.example.com for info
```

## Chaining with URL Encoding

```bash
# URL encode then Base64
echo "special@chars.com" | eoyc -e "url>base64"

# URL encode then uppercase
echo "test data" | eoyc -e "url>upcase"
# Output: TEST%20DATA
```

## Note on Line Feeds

URL encoding will also encode newlines (`\n`) as `%0A` if present in the input.
