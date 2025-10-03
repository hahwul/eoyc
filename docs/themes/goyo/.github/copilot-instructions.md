# Goyo - Zola Theme Development Instructions

**ALWAYS follow these instructions first and fallback to additional search and context gathering only when the information here is incomplete or found to be in error.**

Goyo is a Zola theme for static site generation that creates clean, minimalist documentation sites. This repository serves both as the theme itself and as a documentation/demo site showcasing the theme's capabilities.

## Working Effectively

### Prerequisites Installation
Install required tools in this exact order:

```bash
# Install Zola (static site generator)
cd /tmp
wget https://github.com/getzola/zola/releases/download/v0.21.0/zola-v0.21.0-x86_64-unknown-linux-gnu.tar.gz
tar -xzf zola-v0.21.0-x86_64-unknown-linux-gnu.tar.gz
sudo mv zola /usr/local/bin/
zola --version  # Should show: zola 0.21.0

# Install Just (task runner)
wget https://github.com/casey/just/releases/download/1.42.4/just-1.42.4-x86_64-unknown-linux-musl.tar.gz
tar -xzf just-1.42.4-x86_64-unknown-linux-musl.tar.gz
sudo mv just /usr/local/bin/
just --version  # Should show: just 1.42.4
```

### Project Setup
Bootstrap the project dependencies:

```bash
# CRITICAL: Fix TailwindCSS architecture mismatch for x86_64 systems
rm -f src/tailwindcss  # Remove if exists
curl -sLo src/tailwindcss https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64
chmod +x src/tailwindcss

# Download DaisyUI dependencies
curl -sLo src/daisyui.js https://github.com/saadeghi/daisyui/releases/latest/download/daisyui.js
curl -sLo src/daisyui-theme.js https://github.com/saadeghi/daisyui/releases/latest/download/daisyui-theme.js

# Verify TailwindCSS works
src/tailwindcss --help
```

**IMPORTANT:** The `just setup-linux` command in the justfile downloads the ARM64 version of TailwindCSS which will NOT work on x86_64 systems. Always use the manual setup above.

### Build Process
Build the complete site:

```bash
just build
```

**TIMING:** Build completes in ~0.5 seconds. NEVER CANCEL builds - they complete quickly.

This command:
1. Compiles CSS with TailwindCSS (~190ms)
2. Builds the static site with Zola (~140ms)
3. Creates 32 pages and 14 sections
4. Generates multilingual content (English + Korean)

### Development Server
Start the development server:

```bash
just dev
```

This runs the build process then starts the Zola development server at `http://127.0.0.1:1111`. The server automatically rebuilds on file changes.

**TIMING:** Server startup takes ~0.5 seconds. NEVER CANCEL - it starts quickly.

### Validation Commands
Always run these validation steps after making changes:

```bash
# Check internal links and site structure (SKIP external link check due to network restrictions)
zola check --skip-external-links

# Clean build test
rm -rf public && just build

# Verify dev server works
just dev  # Then test http://127.0.0.1:1111 in another terminal
```

## Manual Validation Requirements

After making any changes to the theme or content:

1. **Build Validation**: Always run a clean build and verify it completes without errors
2. **Server Test**: Start the dev server and verify the homepage loads at `http://127.0.0.1:1111`
3. **Content Check**: Verify key pages render correctly:
   - Landing page: `http://127.0.0.1:1111` (should show "Welcome to Goyo!")
   - Documentation: `http://127.0.0.1:1111/introduction/`
   - Korean version: `http://127.0.0.1:1111/ko/`
4. **Theme Features**: Verify core theme functionality works:
   - Dark/light mode toggle
   - Navigation menu
   - Sidebar navigation
   - Search functionality

## Common Tasks and Navigation

### Repository Structure
```
/home/runner/work/goyo/goyo/
├── .github/workflows/       # GitHub Actions deployment
├── content/                 # Markdown content files
├── static/                  # Static assets (images, fonts, etc.)
├── templates/               # Zola HTML templates
├── src/                     # Source files and downloaded tools
├── public/                  # Generated site (created by build)
├── justfile                 # Build automation tasks
├── config.toml             # Zola site configuration
└── theme.toml              # Theme metadata
```

### Key Commands Reference
```bash
# List all available tasks
just

# Setup dependencies (use manual method above instead)
just setup-linux  # ⚠️ Downloads wrong architecture - don't use

# Build only
just build

# Build and serve with live reload
just dev

# Clean build
rm -rf public && just build

# Internal link checking
zola check --skip-external-links

# Check Zola help
zola --help
```

### Content Development
- Edit content in `content/` directory using Markdown
- Multilingual support: English files use `.md`, Korean files use `.ko.md`
- Landing page configuration is in `content/_index.md`
- Theme templates are in `templates/` directory

### Theme Development
- CSS source files are in `src/main.css`
- TailwindCSS configuration uses DaisyUI components
- Templates use Zola's Tera templating engine
- Static assets go in `static/` directory

### GitHub Actions
- Automatic deployment configured in `.github/workflows/zola.yml`
- Builds and deploys to GitHub Pages on push to main branch
- Target site: https://goyo.hahwul.com

## Known Issues and Workarounds

1. **Architecture Mismatch**: The `just setup-linux` command downloads ARM64 TailwindCSS binary which fails on x86_64. Always use the manual setup commands provided above.

2. **External Link Checking**: Running `zola check` without `--skip-external-links` will fail due to network restrictions in most CI/build environments. Always use `zola check --skip-external-links`.

3. **Binary Dependencies**: The `src/tailwindcss` binary is excluded from git (in .gitignore) and must be downloaded after each fresh clone.

## Time Expectations

- **NEVER CANCEL** any commands - all operations complete in under 1 second
- Bootstrap/Setup: ~30 seconds (downloading dependencies)
- Clean Build: ~0.5 seconds
- Development Server Startup: ~0.5 seconds  
- Link Checking: ~0.1 seconds

## Build Dependencies

The project requires these exact versions:
- **Zola**: v0.21.0 (static site generator)
- **Just**: v1.42.4+ (task runner) 
- **TailwindCSS**: Latest (downloaded binary, architecture-specific)
- **DaisyUI**: Latest (JavaScript libraries)

All dependencies are downloaded and managed locally in the `src/` directory.