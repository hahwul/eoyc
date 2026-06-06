# Aliases
alias b := build
alias ds := docs-serve
alias db := docs-build
alias vc := version-check
alias vu := version-update

# List available tasks.
default:
    @just --list

# Build the eoyc binary.
[group('build')]
build:
    shards install
    shards build

# Clean build artifacts and dependencies.
[group('build')]
clean:
    rm -rf bin/
    rm -rf lib/

# Auto-format code and fix lint issues.
[group('development')]
fix:
    crystal tool format
    crystal run lib/ameba/bin/ameba.cr -- --fix

# Check code format and lint without changes.
[group('development')]
check:
    crystal tool format --check
    crystal run lib/ameba/bin/ameba.cr

# Run all tests.
[group('development')]
test:
    crystal spec

# Check version consistency across all files.
[group('development')]
version-check:
    crystal run scripts/version_check.cr

# Update version across all files.
[group('development')]
version-update:
    crystal run scripts/version_update.cr

# Serve the docs site locally (requires hwaro: https://github.com/hahwul/hwaro).
[group('documents')]
docs-serve:
    @cd docs && hwaro serve

# Build the docs site (requires hwaro: https://github.com/hahwul/hwaro).
[group('documents')]
docs-build:
    @cd docs && hwaro build
