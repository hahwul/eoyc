+++
title = "Pretty Link"
weight = 4
+++

Create beautiful link cards that display URLs with titles, descriptions, and optional images. Perfect for showcasing external resources, references, or related links in an attractive card format.

## Basic Usage

{{ pretty_link(url="https://github.com/hahwul/goyo") }}

```jinja2
{{/* pretty_link(url="https://github.com/hahwul/goyo") */}}
```

## With Title

{{ pretty_link(url="https://github.com/hahwul/goyo", title="Goyo Theme") }}

```jinja2
{{/* pretty_link(url="https://github.com/hahwul/goyo", title="Goyo Theme") */}}
```

## With Title and Description

{{ pretty_link(url="https://github.com/hahwul/goyo", title="Goyo Theme", description="A clean and minimalist Zola theme inspired by the Korean word for calm and serene.") }}

```jinja2
{{/* pretty_link(url="https://github.com/hahwul/goyo", title="Goyo Theme", description="A clean and minimalist Zola theme inspired by the Korean word for calm and serene.") */}}
```

## With Image

{{ pretty_link(url="https://github.com/hahwul/goyo", title="Goyo Theme", description="A clean and minimalist Zola theme inspired by the Korean word for calm and serene.", image="/images/goyo.png") }}

```jinja2
{{/* pretty_link(url="https://github.com/hahwul/goyo", title="Goyo Theme", description="A clean and minimalist Zola theme inspired by the Korean word for calm and serene.", image="/images/goyo.png") */}}
```

## Parameters

- `url` (required): The URL to link to
- `title` (optional): The title of the link. If not provided, the URL will be used as the title
- `description` (optional): A description of the link
- `image` (optional): An image URL to display alongside the link
