---
title: "Hash & Digest Encoders"
weight: 2
---

Hash functions create fixed-size outputs (digests) from variable-size inputs. They are one-way functions - you cannot decode them back to the original.

## MD5

**Algorithm:** MD5 (Message Digest Algorithm 5)

Produces a 128-bit (32 hexadecimal characters) hash value. Note: MD5 is not cryptographically secure and should not be used for security purposes.

### Usage

```bash
echo "password" | eoyc -e "md5"
# Output: 5f4dcc3b5aa765d61d8327deb882cf99
```

### Output Format

Hexadecimal string (32 characters)

## SHA1

**Algorithm:** SHA-1 (Secure Hash Algorithm 1)

Produces a 160-bit hash value, typically rendered as Base64 for compact representation.

### Usage

```bash
echo "test" | eoyc -e "sha1"
# Output: qUqP5cyxm6YcTAhz05Hph5gvu9M=
```

### Output Format

Base64 encoded string

## sha1-hex

Same as SHA1 but outputs in hexadecimal format.

### Usage

```bash
echo "test" | eoyc -e "sha1-hex"
# Output: a94a8fe5ccb19ba61c4c0873d391e987982fbbd3
```

### Output Format

Hexadecimal string (40 characters)

## SHA256

**Algorithm:** SHA-256 (Secure Hash Algorithm 256-bit)

Produces a 256-bit hash value, rendered as Base64.

### Usage

```bash
echo "test" | eoyc -e "sha256"
# Output: n4bQgYhMfWWaL+qgxVrQFaO/TxsrC4Is0V1sFbDwCgg=
```

### Output Format

Base64 encoded string

### Use Cases

- Password hashing (with salt)
- Data integrity verification
- Digital signatures

## sha256-hex

Same as SHA256 but outputs in hexadecimal format.

### Usage

```bash
echo "test" | eoyc -e "sha256-hex"
# Output: 9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08
```

### Output Format

Hexadecimal string (64 characters)

## SHA512

**Algorithm:** SHA-512 (Secure Hash Algorithm 512-bit)

Produces a 512-bit hash value, rendered as Base64.

### Usage

```bash
echo "test" | eoyc -e "sha512"
# Output: 7iaw3Ur350mqGo7jwQrpkj9hiYB3Lkc/iBml1JQODbJ6wYX4oOHV+E+IvIh/1nsUNzLDBMxfqa2Ob1f1ACio/w==
```

### Output Format

Base64 encoded string

## sha512-hex

Same as SHA512 but outputs in hexadecimal format.

### Usage

```bash
echo "test" | eoyc -e "sha512-hex"
# Output: ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fff5b143712c026c914a1acd0c1d0e7c5e5b48e
```

### Output Format

Hexadecimal string (128 characters)

## Combining Hashes in Chains

```bash
# MD5 then SHA256
echo "data" | eoyc -e "md5>sha256"

# Base64 encode before hashing
echo "data" | eoyc -e "base64>sha512"

# Multiple hash transformations
echo "data" | eoyc -e "md5>base64>sha1"
```

## Security Considerations

- **MD5**: Not secure for cryptographic purposes, use SHA-256 or higher
- **SHA-1**: Deprecated for security-critical applications, use SHA-256 or higher
- **SHA-256/SHA-512**: Recommended for security applications
- Always use salts when hashing passwords
