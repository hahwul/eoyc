# Eoyc Documentation

This directory contains the documentation site for Eoyc, built with [Zola](https://www.getzola.org/) using the [Goyo](https://github.com/hahwul/goyo) theme.

## Structure

```
docs/
├── config.toml          # Zola configuration
├── content/             # Documentation content
│   ├── _index.md        # Landing page
│   ├── get_started/     # Getting started guides
│   │   ├── installation/
│   │   ├── usage/
│   │   └── examples/
│   ├── encoders/        # Encoder reference documentation
│   │   ├── base64/
│   │   ├── digests/
│   │   ├── hex/
│   │   ├── url/
│   │   ├── text/
│   │   └── binary/
│   └── background/      # Project background and philosophy
├── static/              # Static assets (images, etc.)
├── themes/              # Zola themes
│   └── goyo/            # Goyo theme
└── public/              # Generated site (not committed)
```

## Prerequisites

Install Zola (0.19.0 or higher):

### macOS
```bash
brew install zola
```

### Linux
```bash
# Download from https://github.com/getzola/zola/releases
curl -sL https://github.com/getzola/zola/releases/download/v0.19.2/zola-v0.19.2-x86_64-unknown-linux-gnu.tar.gz | tar xz
sudo mv zola /usr/local/bin/
```

### Windows
```powershell
choco install zola
```

Or download binaries from: https://github.com/getzola/zola/releases

## Development

### Serve the documentation locally

```bash
# From repository root
cd docs
zola serve
```

The site will be available at http://127.0.0.1:1111

### Build the documentation

```bash
# From repository root
cd docs
zola build
```

The built site will be in the `public/` directory.

### Using justfile commands

From the repository root:

```bash
# Serve documentation
just docs-serve

# Build documentation
just docs-build
```

## Adding Content

### Create a new page

1. Create a new directory in `content/` for the section
2. Add an `index.md` file with front matter:

```markdown
---
title: "Your Page Title"
weight: 1
---

Your content here...
```

### Update existing pages

Simply edit the markdown files in `content/`.

### Add images

Place images in `static/images/` and reference them in markdown:

```markdown
![Alt text](/images/your-image.png)
```

## Configuration

Edit `config.toml` to update:
- Site title and base URL
- Navigation menu
- Social media links
- Theme settings

## Deployment

The documentation can be deployed to:
- GitHub Pages
- Netlify
- Vercel
- Any static site host

Simply build the site and deploy the `public/` directory.

## Theme

This documentation uses the [Goyo theme](https://github.com/hahwul/goyo), a minimalist documentation theme for Zola.

Theme features:
- Clean, modern design
- Dark/light mode support
- Built-in search
- Responsive layout
- Syntax highlighting
- Table of contents

## License

The documentation content is part of the Eoyc project and follows the same MIT License.
