---
title: "Installation"
weight: 1
---

Eoyc can be installed in several ways, depending on your preference and environment.

## From Homebrew

For macOS users, Eoyc is available via Homebrew:

```bash
brew tap hahwul/eoyc
brew install eoyc
```

## From Source

To build Eoyc from source, you'll need to have Crystal installed (version 1.7.3 or higher).

### Clone the repository

```bash
git clone https://github.com/hahwul/eoyc
cd eoyc
```

### Build the application

```bash
shards install
shards build
```

The compiled binary will be located at `bin/eoyc`.

### Run

```bash
./bin/eoyc -h
```

## Verify Installation

After installation, verify that eoyc is working correctly:

```bash
eoyc --version
# Output: 0.2.0
```

```bash
echo "test" | eoyc -e "base64"
# Output: dGVzdA==
```

## Next Steps

Now that you have eoyc installed, check out the [Usage](/get_started/usage) guide to learn how to use it effectively.
