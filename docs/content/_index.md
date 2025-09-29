+++
template = "landing.html"

[extra.hero]
title = "Welcome to EOYC!"
badge = "v0.2.0"
description = "Encoding Only Your Choices - A powerful CLI tool for encoding and hashing strings with flexible options"
image = "/images/preview.jpg"
cta_buttons = [
    { text = "Get Started", url = "/get_started/installation", style = "primary" },
    { text = "View on GitHub", url = "https://github.com/hahwul/eoyc", style = "secondary" },
]

[[extra.features]]
title = "Multiple Encoders"
desc = "Support for base64, MD5, SHA1, SHA256, SHA512, hex, URL encoding, ROT13, and more transformation options."
icon = "fa-solid fa-key"

[[extra.features]]
title = "Encoder Chaining"
desc = "Chain multiple encoders together using '>', '|', or ',' characters for complex transformations."
icon = "fa-solid fa-link"

[[extra.features]]
title = "Flexible Input"
desc = "Process entire lines, specific strings, or regex pattern matches with precise control over what gets encoded."
icon = "fa-solid fa-filter"

[[extra.features]]
title = "Text Transformations"
desc = "Beyond encoding - uppercase, lowercase, reverse, redact, binary, octal, and Unicode operations."
icon = "fa-solid fa-text-width"

[[extra.features]]
title = "Pipeline Friendly"
desc = "Built for command-line workflows - reads from stdin, pipes well with other tools, Crystal-fast performance."
icon = "fa-solid fa-terminal"

[[extra.features]]
title = "Simple & Powerful"
desc = "Easy-to-use interface with powerful regex and string selection capabilities for targeted encoding."
icon = "fa-solid fa-bolt"

[extra.final_cta_section]
title = "Contributing"
description = "EOYC is an open-source project made with ❤️. If you want to contribute to this project, please see the GitHub repository and submit a pull request with your improvements!"
button = { text = "View on GitHub", url = "https://github.com/hahwul/eoyc" }
+++