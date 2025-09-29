+++
title = "Installation"
weight = 1
+++

# Installation

## Homebrew (macOS/Linux)

The easiest way to install EOYC is using Homebrew:

```bash
brew tap hahwul/eoyc
brew install eoyc
```

## From Releases (Linux/macOS/Windows)

Download the latest binary from [GitHub Releases](https://github.com/hahwul/eoyc/releases):

```bash
# Example for Linux x64
wget https://github.com/hahwul/eoyc/releases/latest/download/eoyc-linux-x64
chmod +x eoyc-linux-x64
sudo mv eoyc-linux-x64 /usr/local/bin/eoyc
```

## From Source

### Prerequisites

- Crystal 1.7.3 or later
- Git

### Build Instructions

```bash
# Clone the repository
git clone https://github.com/hahwul/eoyc
cd eoyc

# Install dependencies
shards install

# Build the binary
shards build

# Run from local build
./bin/eoyc --version
```

### Crystal Installation

If you don't have Crystal installed, you can install it from GitHub releases:

```bash
# Download and install Crystal 1.17.1 (or latest)
curl -L https://github.com/crystal-lang/crystal/releases/download/1.17.1/crystal-1.17.1-1-linux-x86_64.tar.gz | tar xz
export PATH=$PWD/crystal-1.17.1-1/bin:$PATH
crystal --version  # Should show Crystal 1.17.1
```

## Verify Installation

After installation, verify that EOYC is working correctly:

```bash
eoyc --version
# Should output: 0.2.0

eoyc --help
# Should show usage information
```

## Next Steps

- [Quick Start Guide](/get_started/quick_start) - Learn basic usage
- [Usage Examples](/usage/basic) - See EOYC in action
- [Encoder Reference](/encoders/overview) - Explore all available encoders