# GitHub Copilot Instructions for EOYC

## Project Overview

EOYC (Encoding Only Your Choices) is a Crystal CLI tool for encoding and hashing strings with flexible options. It supports various encoding chains including base64, MD5, SHA1, URL encoding, and case transformations.

## Prerequisites

### Crystal Language Installation

Install Crystal 1.11.2+ from GitHub releases:

```bash
# Download and install Crystal 1.17.1 (or latest)
curl -L https://github.com/crystal-lang/crystal/releases/download/1.17.1/crystal-1.17.1-1-linux-x86_64.tar.gz | tar xz
export PATH=$PWD/crystal-1.11.2-1/bin:$PATH
crystal --version  # Should show Crystal 1.17.1
```

**Time expectation**: ~30 seconds for download and extraction

## Development Setup

### 1. Dependencies Installation
```bash
shards install
```
**Time expectation**: ~1 second

### 2. Build Process
```bash
shards build
```
**Time expectation**: ~1.5 seconds

**Total build pipeline**: ~5 seconds (including Crystal installation)

### 3. Verify Installation
```bash
./bin/eoyc --version
./bin/eoyc --help
```

## Validation Scenarios

### 1. Basic String Encoding
```bash
echo "test" | ./bin/eoyc -s test -e "base64"
# Expected: dGVzdA==
```

### 2. Chain Encoding
```bash
echo "abcdefghijk" | ./bin/eoyc -s bcde -e "md5>base64>sha1"
# Expected: aCFV4rFRO+h/0cCngUl1Ccahz040=fghijk
```

### 3. Full Line Encoding
```bash
echo "abcdefghijk" | ./bin/eoyc -a -e "md5>base64>sha1"
# Expected: 9EG0tX9wWhKDghHJECSS8E+XZ3U=
```

### 4. Regex Pattern Matching
```bash
echo "user@domain.com" | ./bin/eoyc -r "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" -e "sha1"
# Should encode the email part with SHA1
```

### 5. URL Encoding
```bash
echo "https://www.example.com" | ./bin/eoyc -a -e "url"
# Expected: https%3A%2F%2Fwww.example.com
```

## Testing

### Run Test Suite
```bash
crystal spec
```
**Time expectation**: ~2 seconds (4 tests should pass)

### Run with Verbose Output
```bash
crystal spec -v
```

### Individual Test Files
- `spec/encoders_spec.cr` - Encoder functionality tests
- `spec/eoyc_spec.cr` - Main CLI tests
- `spec/utils_spec.cr` - Utility function tests

## Code Quality

### Format Check
```bash
crystal tool format --check
```

### Auto-format Code
```bash
crystal tool format
```

### Linting (if ameba is available)
```bash
ameba
```

## Project Structure

```
├── src/
│   ├── eoyc.cr           # Main CLI entry point
│   ├── encoders.cr       # Encoding implementations
│   ├── encoders/         # Individual encoder modules
│   └── utils.cr          # Utility functions
├── spec/                 # Test files
├── shard.yml            # Project dependencies
├── justfile             # Build automation
└── .github/
    └── workflows/       # CI/CD pipelines
```

## Encoder Chaining

Use `>`, `|`, or `,` to chain encoders:
```bash
-e "base64>md5"      # base64 then md5
-e "url|upcase|md5"  # url encode, uppercase, then md5
-e "url>upcase,md5"  # same as above
```

## CI/CD Integration

The project includes GitHub Actions workflows:
- `crystal.yml` - Crystal CI pipeline
- `release-*.yml` - Release automation
- `publish-*.yml` - Package publishing

## Development Workflow

### Make Changes
1. Edit source files in `src/`
2. Run tests: `crystal spec`
3. Format code: `crystal tool format`
4. Build: `shards build`
5. Test binary: `./bin/eoyc --help`

### Quick Development Commands
```bash
# Using justfile
just build    # Build the application
just test     # Run tests
just check    # Check formatting and linting
just fix      # Auto-format and fix issues
```

## Known Limitations

- Output file flag (`-o`) is not fully implemented in current version
- Some advanced regex patterns may need escaping in shell

## Troubleshooting

### Crystal Not Found
Ensure Crystal is in PATH after installation:
```bash
export PATH=$PWD/crystal-1.11.2-1/bin:$PATH
```

### Build Failures
Check Crystal version compatibility:
```bash
crystal --version  # Should be 1.7.3+
```

### Test Failures
Run individual test files to isolate issues:
```bash
crystal spec spec/encoders_spec.cr -v
```

## Time Expectations Summary

- Crystal installation: ~30 seconds
- Dependencies install: ~1 second
- Build: ~1.5 seconds
- Test suite: ~2 seconds
- **Total setup**: ~35 seconds from fresh environment

All operations are designed to be fast for efficient development cycles.
