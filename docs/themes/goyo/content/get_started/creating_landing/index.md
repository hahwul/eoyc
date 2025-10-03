+++
title = "Creating a Landing Page"
description = "Learn how to create a modern, feature-rich landing page with Goyo."
weight = 3
sort_by = "weight"

[extra]
+++

The landing page is the first page visitors see. In Goyo, it's built using `landing.html` and configured in `content/_index.md`. This allows you to create a rich, engaging entry point for your project.

To create a landing page for another language, simply create a corresponding file, such as `content/_index.ko.md`.

## Template Configuration

First, ensure your `_index.md` file is set to use the `landing.html` template.

```toml
template = "landing.html"
```

## Full Configuration Example

The Goyo landing page is highly customizable through the `[extra]` section of your `_index.md`. Below is a full example showcasing all available sections. You can omit any section you don't need, and it won't be rendered.

```toml
+++
template = "landing.html"
title = "Goyo"

[extra]
version = "v0.1.0"

# Hero Section
# The main section at the top of the page.
[extra.hero]
title = "Welcome to Goyo!"
badge = "✨ Minimalist Documentation Theme"
description = "A simple and clean Zola theme for documentation."
image = "/images/landing.jpg" # Background image
cta_buttons = [
    { text = "Get Started", url = "/get-started/installation/", style = "primary" },
    { text = "View on GitHub", url = "https://github.com/your/repo", style = "secondary" },
]

# Features Section
# A grid to highlight key features.
[[extra.features]]
title = "Documentation Friendly"
desc = "Provides a clean writing experience for documentation."
icon = "fa-solid fa-book"

[[extra.features]]
title = "Simple Design"
desc = "A theme that pursues minimalism."
icon = "fa-solid fa-minimize"

# Trust Section
# Display logos of companies or projects that trust you.
[extra.trust_section]
title = "Trusted by the Best"
logos = [
    { src = "/images/logo1.svg", alt = "Company One" },
    { src = "/images/logo2.svg", alt = "Company Two" },
]

# Social Proof Section
# Showcase testimonials from your users.
[extra.social_proof_section]
title = "What Our Users Say"
testimonials = [
    {
        author = "Jane Doe",
        role = "Developer at TechCorp",
        quote = "Goyo has transformed our documentation process. It's simple, elegant, and incredibly fast.",
        avatar = "/images/avatars/jane.png"
    },
    {
        author = "John Smith",
        role = "Project Manager at Innovate LLC",
        quote = "The best Zola theme for documentation out there. The setup was a breeze.",
        avatar = "/images/avatars/john.png"
    },
]

# Final Call to Action Section
# A final prompt for users before the footer.
# You can also add an image field to show an image above the CTA text.
[extra.final_cta_section]
title = "Ready to Get Started?"
description = "Begin your journey with Goyo today and create beautiful documentation with ease."
button = { text = "Start Now", url = "/get-started/installation/" }
image = "/images/contribute.png" # (Optional) Image above the CTA section
+++
```

## Section Breakdown

- **`[extra.hero]`**: The main banner. It includes a title, description, a full-screen background image, and a list of call-to-action buttons (`cta_buttons`). Each button has `text`, `url`, and `style` (`primary` for the main button, `secondary` for the other).

- **`[[extra.features]]`**: A list of features to display in a grid. Each feature has a `title`, `desc` (description), and an `icon` from [Font Awesome](https://fontawesome.com/).

- **`[extra.trust_section]`**: Showcases logos of companies or projects. `logos` is a list where each item has an image `src` and `alt` text.

- **`[extra.social_proof_section]`**: Displays user testimonials. `testimonials` is a list of objects, each with an `author`, `role`, `quote`, and `avatar` image.

- **`[extra.final_cta_section]`**: A final call-to-action block with a `title`, `description`, and a single `button` with `text` and `url`.
  You can also add an optional `image` field (e.g. `image = "/images/contribute.png"`) to display an image above the CTA text.
