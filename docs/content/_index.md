+++
template = "landing.html"

[extra.hero]
title = "Welcome to Eoyc!"
badge = "v0.2.0"
description = "Encoding Only Your Choices - A powerful CLI tool for encoding and hashing strings with flexible chain operations"
# image = "/images/preview.jpg" # Background image
cta_buttons = [
    { text = "Get Started", url = "/get_started/installation", style = "primary" },
    { text = "View on GitHub", url = "https://github.com/hahwul/eoyc", style = "secondary" },
]

[[extra.features]]
title = "Multiple Encoders"
desc = "Support for Base64, MD5, SHA1/256/512, Hex, URL encoding, ROT13, Binary, Octal, Unicode, and more."
icon = "fa-solid fa-code"

[[extra.features]]
title = "Chain Operations"
desc = "Chain multiple encoders together using '>', '|', or ',' to create complex encoding pipelines."
icon = "fa-solid fa-link"

[[extra.features]]
title = "Flexible Selection"
desc = "Encode entire lines, specific strings with -s, or regex-matched patterns with -r for precise control."
icon = "fa-solid fa-filter"

[[extra.features]]
title = "Stream Processing"
desc = "Process data from STDIN, making it perfect for pipeline operations and batch processing."
icon = "fa-solid fa-stream"

[[extra.features]]
title = "Easy Installation"
desc = "Available via Homebrew for quick setup. Built with Crystal for high performance."
icon = "fa-solid fa-download"

[[extra.features]]
title = "Open Source"
desc = "Free and open source under MIT license. Contributions are welcome!"
icon = "fa-brands fa-github"

[extra.final_cta_section]
title = "Contributing"
description = "Eoyc is an open-source project made with ❤️. If you want to contribute to this project, please see CONTRIBUTING.md and submit a pull request with your cool content!"
button = { text = "View on GitHub", url = "https://github.com/hahwul/eoyc" }
+++
