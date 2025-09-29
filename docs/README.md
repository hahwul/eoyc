# EOYC Documentation

This directory contains the Zola-based documentation for EOYC using the Goyo theme.

## Structure

```
docs/
├── config.toml              # Zola configuration
├── content/                 # Documentation content
│   ├── _index.md           # Landing page
│   ├── get_started/        # Getting started guides
│   │   ├── installation/   # Installation instructions
│   │   └── quick_start/    # Quick start guide
│   ├── usage/              # Usage documentation
│   │   ├── basic/          # Basic usage
│   │   └── examples/       # Usage examples
│   ├── encoders/           # Encoder documentation
│   │   ├── overview/       # Encoder overview
│   │   └── chaining/       # Encoder chaining
│   └── contributing/       # Contributing guide
├── static/                 # Static assets
│   └── images/            # Images and logos
└── themes/                # Themes
    └── goyo/              # Goyo theme (submodule)
```

## Building the Documentation

### Prerequisites

- [Zola](https://www.getzola.org/documentation/getting-started/installation/) (v0.17.2 recommended)

### Build Commands

```bash
# Check the site for errors
zola check

# Build the site
zola build

# Serve locally for development
zola serve
```

### Theme

The documentation uses the [Goyo theme](https://github.com/hahwul/goyo) which provides:

- Clean, minimal design
- Responsive layout
- Syntax highlighting
- Search functionality
- Multi-language support

## Content

The documentation includes:

1. **Getting Started**
   - Installation instructions for multiple platforms
   - Quick start guide with basic examples

2. **Usage Guide**
   - Basic usage patterns
   - Advanced examples and real-world scenarios

3. **Encoder Documentation**
   - Complete overview of all available encoders
   - Encoder chaining guide and examples

4. **Contributing Guide**
   - Development setup instructions
   - Code style guidelines
   - Pull request process

## Deployment

The documentation can be deployed to:
- GitHub Pages
- Netlify
- Vercel
- Any static hosting service

For GitHub Pages, add a workflow to build and deploy on push to main.

## Development

To modify the documentation:

1. Edit content in the `content/` directory
2. Update configuration in `config.toml`
3. Add static assets to `static/`
4. Test locally with `zola serve`

The content is written in Markdown with TOML frontmatter for metadata.