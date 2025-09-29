+++
title = "Contributing"
weight = 4
+++

# Contributing to EOYC

We welcome contributions to EOYC! This guide will help you get started with contributing to the project.

## Development Setup

### Prerequisites

- Crystal 1.7.3 or later
- Git
- Basic knowledge of Crystal programming language

### Setting Up Your Development Environment

1. **Fork and Clone**
   ```bash
   git clone https://github.com/YOUR_USERNAME/eoyc.git
   cd eoyc
   ```

2. **Install Crystal**
   ```bash
   # Download and install Crystal 1.17.1 (or latest)
   curl -L https://github.com/crystal-lang/crystal/releases/download/1.17.1/crystal-1.17.1-1-linux-x86_64.tar.gz | tar xz
   export PATH=$PWD/crystal-1.17.1-1/bin:$PATH
   ```

3. **Install Dependencies**
   ```bash
   shards install
   ```

4. **Build and Test**
   ```bash
   # Build the project
   shards build
   
   # Run tests
   crystal spec -v
   
   # Test the binary
   ./bin/eoyc --version
   ```

## Project Structure

```
├── src/
│   ├── eoyc.cr           # Main CLI entry point
│   ├── encoders.cr       # Encoder aggregation
│   ├── encoders/         # Individual encoder modules
│   │   ├── core.cr       # Encoder framework
│   │   ├── base64.cr     # Base64 encoders
│   │   ├── digests.cr    # Hash/digest encoders
│   │   └── ...           # Other encoder modules
│   └── utils.cr          # Utility functions
├── spec/                 # Test files
├── docs/                 # Documentation (Zola site)
└── justfile             # Build automation
```

## Adding New Encoders

To add a new encoder, follow these steps:

### 1. Create the Encoder Module

Create a new file in `src/encoders/` (e.g., `src/encoders/myencoder.cr`):

```crystal
require "./core"

# Register your encoder
Encoders.register(
  EncoderSpec.new("myencoder", %w[myencoder my-encoder], "Description of encoder") { |s|
    # Your encoding logic here
    transform_string(s)
  }
)

# Add any helper functions
private def transform_string(str)
  # Implementation
  str.transform_somehow
end
```

### 2. Register the Module

Add a require line to `src/encoders.cr`:

```crystal
require "./encoders/myencoder"
```

### 3. Add Tests

Add tests to `spec/encoders_spec.cr`:

```crystal
it "myencoder single case" do
  result = encode("input", ["myencoder"])
  result.should eq("expected_output")
end

it "myencoder round trip" do
  original = "test"
  encoded = encode(original, ["myencoder"])
  decoded = encode(encoded, ["myencoder-decode"])
  decoded.should eq(original)
end
```

### 4. Update Documentation

Add your encoder to:
- `docs/content/encoders/overview/_index.md`
- `docs/content/encoders/reference/_index.md` (if it exists)

## Code Quality Standards

### Formatting
```bash
# Format code
crystal tool format

# Check formatting
crystal tool format --check
```

### Testing
```bash
# Run all tests
crystal spec

# Run tests with verbose output
crystal spec -v

# Run specific test file
crystal spec spec/encoders_spec.cr
```

### Using Justfile
The project includes a `justfile` for common tasks:

```bash
# Build project
just build

# Run tests
just test

# Check code quality
just check

# Auto-fix issues
just fix
```

## Contribution Guidelines

### Code Style

1. **Follow Crystal conventions**
   - Use snake_case for methods and variables
   - Use PascalCase for classes and modules
   - Use meaningful variable names

2. **Write clear code**
   - Add comments for complex logic
   - Keep methods small and focused
   - Use descriptive method names

3. **Handle errors gracefully**
   - Return original input on encoding failures
   - Don't crash on invalid input
   - Use proper exception handling

### Testing Requirements

1. **All new code must have tests**
2. **Tests should cover edge cases**
3. **Maintain existing test coverage**
4. **Include round-trip tests for encode/decode pairs**

### Documentation

1. **Update relevant documentation**
2. **Add examples for new encoders**
3. **Keep README.md updated**
4. **Write clear commit messages**

## Submitting Changes

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/my-new-encoder
   ```

2. **Make your changes**
   - Write code
   - Add tests
   - Update documentation

3. **Test thoroughly**
   ```bash
   just test
   just check
   ```

4. **Commit with clear messages**
   ```bash
   git add .
   git commit -m "Add myencoder with encode/decode support"
   ```

5. **Push and create PR**
   ```bash
   git push origin feature/my-new-encoder
   ```

### PR Requirements

- [ ] All tests pass
- [ ] Code is properly formatted
- [ ] Documentation is updated
- [ ] New encoders have comprehensive tests
- [ ] Changes are backward compatible
- [ ] Clear description of changes

## Issue Reporting

### Bug Reports
Please include:
- EOYC version
- Operating system
- Input data (if safe to share)
- Expected vs actual output
- Steps to reproduce

### Feature Requests
Please include:
- Clear description of the feature
- Use case or motivation
- Proposed API (if applicable)
- Example usage

## Community

### Communication
- **GitHub Issues** - Bug reports and feature requests
- **GitHub Discussions** - General questions and ideas
- **Pull Requests** - Code contributions

### Code of Conduct
- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Maintain a professional tone

## Getting Help

### Resources
- [Crystal Documentation](https://crystal-lang.org/docs/)
- [EOYC Source Code](https://github.com/hahwul/eoyc)
- [Crystal Style Guide](https://crystal-lang.org/reference/conventions/coding_style.html)

### Questions?
- Open a GitHub Discussion for general questions
- Check existing issues for similar problems
- Review the source code for examples

## Recognition

Contributors are recognized in:
- `CONTRIBUTORS.svg` (automatically generated)
- Release notes
- Project documentation

Thank you for contributing to EOYC! 🎉