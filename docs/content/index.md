+++
title = "Eoyc"

[extra]
landing = true
+++

<div class="bp-hero">
  <div class="bp-hero-badge">v0.3.0</div>
  <h1 class="bp-hero-title">Endless Options, Your Chain</h1>
  <p class="bp-hero-desc">A powerful CLI tool for encoding and hashing strings with flexible chain operations</p>
  <div class="bp-hero-actions">
    <a href="/get_started/installation/" class="bp-btn bp-btn--primary">Get Started</a>
    <a href="https://github.com/hahwul/eoyc" class="bp-btn" target="_blank" rel="noopener">View on GitHub</a>
  </div>
  <div class="bp-hero-demo">
    <pre><code><span class="bp-demo-prompt">$</span> echo "hello world" | eoyc -e "base64>md5>sha1"
<span class="bp-demo-output">YTg3ZmY2Nzk...NTFkNDc2OA==</span>

<span class="bp-demo-prompt">$</span> echo "sensitive data" | eoyc -s "sensitive" -e "redacted"
<span class="bp-demo-output">◼◼◼◼◼◼◼◼◼ data</span></code></pre>
  </div>
</div>

<div class="bp-features">
  <div class="bp-home-section-title">Features</div>
  <div class="bp-nav-grid">
    <div class="bp-feature-card">
      <div class="bp-feature-title">Multiple Encoders</div>
      <div class="bp-feature-desc">Base64, MD5, SHA1/256/512, Hex, URL, ROT13, Binary, Octal, Unicode, and more.</div>
    </div>
    <div class="bp-feature-card">
      <div class="bp-feature-title">Chain Operations</div>
      <div class="bp-feature-desc">Chain multiple encoders using '>', '|', or ',' to create complex encoding pipelines.</div>
    </div>
    <div class="bp-feature-card">
      <div class="bp-feature-title">Flexible Selection</div>
      <div class="bp-feature-desc">Encode entire lines, specific strings with -s, or regex patterns with -r.</div>
    </div>
    <div class="bp-feature-card">
      <div class="bp-feature-title">Stream Processing</div>
      <div class="bp-feature-desc">Process data from STDIN, perfect for pipeline operations and batch processing.</div>
    </div>
    <div class="bp-feature-card">
      <div class="bp-feature-title">Easy Installation</div>
      <div class="bp-feature-desc">Available via Homebrew for quick setup. Built with Crystal for high performance.</div>
    </div>
    <div class="bp-feature-card">
      <div class="bp-feature-title">Open Source</div>
      <div class="bp-feature-desc">Free and open source under MIT license. Contributions are welcome!</div>
    </div>
  </div>
</div>

<div class="bp-home-section">
  <div class="bp-home-section-title">Quick Start</div>

```bash
brew tap hahwul/eoyc
brew install eoyc

echo "test" | eoyc -e "base64"
# Output: dGVzdA==
```

</div>
