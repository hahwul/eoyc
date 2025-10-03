+++
title = "Configuration"
description = "Learn how to configure Goyo."
weight = 4
sort_by = "weight"

[extra]
+++

Now let's look at the settings for the Goyo theme. It provides various settings to customize the theme. You can use them in `config.toml`.

## Logo
`logo_text` / `logo_image_path` / `logo_image_padding`

- `logo_text`: Text displayed when no logo image is present.
- `logo_image_path`: Path to the logo image.
- `logo_image_padding`: Padding applied to the logo image (optional, e.g. `"5px"`).

```toml
[extra]
logo_text = "Goyo"
logo_image_path = "images/goyo.png"
logo_image_padding = "5px"
```

## Footer
`footer_html`

- `footer_html`: HTML code displayed in the footer.

```toml
[extra]
footer_html = "Powered by <a href='https://www.getzola.org'>Zola</a> and <a href='https://github.com/hahwul/goyo'>Goyo</a>"
```

## Thumbnail
`default_thumbnail`

- `default_thumbnail`: Path to the default thumbnail image.

```toml
[extra]
default_thumbnail = "images/default_thumbnail.jpg"
```

## Twitter
`twitter_site` / `twitter_creator`

- `twitter_site`: Twitter site handle.
- `twitter_creator`: Twitter creator handle.

```toml
[extra]
twitter_site = "@hahwul"
twitter_creator = "@hahwul"
```

## Color
`default_colorset`

- `default_colorset`: Default theme (dark/light).

```toml
[extra]
default_colorset = "dark"
```

## Google Tag
`gtag`

- `gtag`: Google Tag ID.

```toml
[extra]
gtag = "G-XXXXXXXXXX"
```

## Sidebar Expand Depth
`sidebar_expand_depth`

- `sidebar_expand_depth`: Specifies the depth (up to 5) to which sidebar sections should be expanded by default. For example, a value of `1` will only show top-level sections, while `2` will expand the first level of subsections.

```toml
[extra]
sidebar_expand_depth = 2
```

## Navigations
`nav` / `nav_{lang}`

- `nav`: Top navigation menu. name and icon fields is optional.
- `nav_{lang}`: Language-specific navigation menu (e.g., `nav_ko` for Korean). If defined, it will be used instead of the default `nav` for that language.

```toml
[extra]
# Default navigation (used for English and as fallback)
nav = [
    { name = "Documents", url = "/introduction", type = "url", icon = "fa-solid fa-book" },
    { name = "GitHub", url = "https://github.com/hahwul/goyo", type = "url", icon = "fa-brands fa-github" },
    { name = "Links", type = "dropdown", icon = "fa-solid fa-link", members = [
        { name = "Creator Blog", url = "https://www.hahwul.com", type = "url", icon = "fa-solid fa-fire-flame-curved" },
    ] },
]

# Korean navigation (optional)
nav_ko = [
    { name = "문서", url = "/ko/introduction", type = "url", icon = "fa-solid fa-book" },
    { name = "GitHub", url = "https://github.com/hahwul/goyo", type = "url", icon = "fa-brands fa-github" },
    { name = "링크", type = "dropdown", icon = "fa-solid fa-link", members = [
        { name = "제작자 블로그", url = "https://www.hahwul.com", type = "url", icon = "fa-solid fa-fire-flame-curved" },
    ] },
]
```

## Language Aliases
`lang_aliases`

- `lang_aliases`: Custom display names for languages in the language selector dropdown. If not defined, the language code will be displayed. This allows you to show user-friendly names like "English" or "한국어" instead of just "en" or "ko".

```toml
[extra]
# Language display names for the language selector
lang_aliases = { en = "English", ko = "한국어" }
```

You can add as many languages as you need:

```toml
[extra]
lang_aliases = { 
    en = "English", 
    ko = "한국어",
    ja = "日本語",
    id = "Bahasa Indonesia"
}
```

## Disable Theme Toggle
`disable_theme_toggle`

- `disable_theme_toggle`: If set to `true`, the theme toggle button (for switching between dark and light mode) will be hidden from the header.

```toml
[extra]
disable_theme_toggle = true
```

## Disable Root Sidebar Hide
`disable_root_sidebar_hide`

- `disable_root_sidebar_hide`: If set to `true`, the sidebar will not be hidden on the root page (`/` or `/{lang}/`). This allows the sidebar to always be visible, even on the main landing page.

```toml
[extra]
disable_root_sidebar_hide = false
```

{{ image_diff(
    src1="/images/side-home.jpg",
    src2="/images/wide-home.jpg",
    alt="goyo"
) }}

## Comments
`comments`

- `comments`: Comment feature settings (giscus/utterances).

```toml
[extra.comments]
enabled = true
system = "giscus"
repo = "hahwul/goyo"
repo_id = "R_kgDOPHnqwg"
category = "General"
category_id = "DIC_kwDOPHnqws4CspmC"
mapping = "pathname"
strict = "0"
reactions_enabled = "1"
emit_metadata = "0"
input_position = "bottom"
theme = "catppuccin_mocha"
lang = "en"
```
