+++
title = "Background"
weight = 3

[extra]
+++

## About Eoyc

Eoyc (Encoding Only Your Choices) is a command-line tool designed to provide flexible and powerful text encoding and transformation capabilities. Built with Crystal for high performance and ease of use, eoyc enables users to encode specific parts of text using a variety of encoders and hash functions.

## Why Eoyc?

When working with security testing, data processing, or text manipulation, there's often a need to encode or hash specific parts of text while leaving the rest intact. Traditional encoding tools typically work on entire files or streams, but eoyc provides fine-grained control:

- **Selective Encoding**: Encode only specific strings or regex patterns
- **Chain Operations**: Combine multiple encoders in sequence
- **Stream Processing**: Work with STDIN/STDOUT for easy integration in pipelines
- **Multiple Encoders**: Support for 20+ different encoders and transformations

## Design Philosophy

Eoyc follows these core principles:

1. **Simplicity**: Easy to use with intuitive command-line interface
2. **Flexibility**: Multiple ways to select and transform text
3. **Composability**: Chain operations together for complex transformations
4. **Performance**: Built with Crystal for fast execution
5. **Unix Philosophy**: Read from STDIN, write to STDOUT, do one thing well

## Use Cases

### Security Testing
- Encode payloads for web application testing
- Generate various encodings of test strings
- Obfuscate sensitive data in test scenarios

### Data Processing
- Anonymize log files by hashing sensitive information
- Transform data formats in processing pipelines
- Encode URLs or special characters in bulk

### Development
- Test encoding/decoding implementations
- Generate test data in various formats
- Quick command-line encoding utilities

## Architecture

Eoyc is built with a modular encoder system:

```
src/
├── eoyc.cr           # Main CLI entry point
├── encoders.cr       # Encoder aggregation
├── encoders/         # Individual encoder modules
│   ├── core.cr       # Framework and registry
│   ├── base64.cr     # Base64 encoders
│   ├── digests.cr    # Hash functions
│   ├── hex.cr        # Hex encoders
│   ├── url_form.cr   # URL encoders
│   ├── text.cr       # Text transformations
│   ├── binary.cr     # Binary encoders
│   ├── octal.cr      # Octal encoders
│   ├── unicode.cr    # Unicode encoders
│   └── charcode.cr   # Character code encoders
└── utils.cr          # Utility functions
```

Each encoder is registered in a global registry and can be easily extended to support new encoding schemes.

## Technology Stack

- **Language**: Crystal 1.7.3+
- **Build System**: Crystal Shards
- **Package Management**: Homebrew (macOS)
- **Testing**: Crystal Spec

## License

Eoyc is open source software licensed under the MIT License. See the [LICENSE](https://github.com/hahwul/eoyc/blob/main/LICENSE) file for details.

## Contributing

Contributions are welcome! Please see the [GitHub repository](https://github.com/hahwul/eoyc) for more information on how to contribute.

## Author

Created by [@hahwul](https://github.com/hahwul)
- Blog: [https://www.hahwul.com](https://www.hahwul.com)
- Twitter: [@hahwul](https://twitter.com/hahwul)
