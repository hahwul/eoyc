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
    ameba --fix

# Check code formatting and run linter without making changes.
check:
    @echo "Checking code format and running linter..."
    crystal tool format --check
    ameba

# Run all Crystal spec tests.
test:
    @echo "Running tests..."
    crystal spec
