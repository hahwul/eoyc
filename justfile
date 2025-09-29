# Alias
alias b := build

# Default task, lists all available tasks.
default:
    @echo "Listing available tasks..."
    @echo "Aliases: b (build), ds (docs-serve), dsup (docs-supported)"
    @just --list

# Build the application using Crystal Shards.
build:
    @echo "Building the application..."
    shards build

# Automatically format code and fix linting issues.
fix:
    @echo "Formatting code and fixing linting issues..."
    crystal tool format
    ameba --fix || true

# Check code formatting and run linter without making changes.
check:
    @echo "Checking code format and running linter..."
    crystal tool format --check
    ameba || true

# Run all Crystal spec tests.
test:
    @echo "Running tests..."
    crystal spec

# Documentation tasks
docs-check:
    @echo "Checking documentation..."
    cd docs && zola check

docs-build:
    @echo "Building documentation..."
    cd docs && zola build

docs-serve:
    @echo "Serving documentation locally..."
    cd docs && zola serve

# Clean build artifacts
clean:
    @echo "Cleaning build artifacts..."
    rm -rf bin/ lib/ .shards/
