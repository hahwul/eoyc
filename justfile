# Alias
alias b := build
alias ds := docs-serve
alias db := docs-build

# Default task, lists all available tasks.
default:
    @echo "Listing available tasks..."
    @echo "Aliases: b (build), ds (docs-serve), db (docs-build)"
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

# Serve documentation site locally with Zola.
docs-serve:
    @echo "Serving documentation site..."
    @cd docs && zola serve

# Build documentation site with Zola.
docs-build:
    @echo "Building documentation site..."
    @cd docs && zola build
