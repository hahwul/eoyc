+++
title = "Math"
weight = 4
+++

Use the `math` shortcode to render mathematical formulas and equations using [KaTeX](https://katex.org/).

## Basic Usage

The math shortcode accepts a `content` parameter with the LaTeX formula:

{{ math(content="E=mc^2") }}

```jinja2
{{/* math(content="E=mc^2") */}}
```

## Inline Formulas

Use the math shortcode to add inline mathematical expressions:

When {{ math(content="a \ne 0") }}, there are two solutions to {{ math(content="ax^2 + bx + c = 0") }}.

```jinja2
When {{/* math(content="a \ne 0") */}}, there are two solutions to {{/* math(content="ax^2 + bx + c = 0") */}}.
```

## Complex Formulas

The shortcode supports complex LaTeX formulas:

{{ math(content="\displaystyle\sum_{i=1}^{n} i = \frac{n(n+1)}{2}") }}

```jinja2
{{/* math(content="\displaystyle\sum_{i=1}^{n} i = \frac{n(n+1)}{2}") */}}
```

## Greek Letters

{{ math(content="\alpha, \beta, \gamma, \delta, \epsilon") }}

```jinja2
{{/* math(content="\alpha, \beta, \gamma, \delta, \epsilon") */}}
```

## Fractions and Roots

{{ math(content="\frac{a}{b}, \sqrt{x}, \sqrt[n]{x}") }}

```jinja2
{{/* math(content="\frac{a}{b}, \sqrt{x}, \sqrt[n]{x}") */}}
```

## Matrices

{{ math(content="\begin{pmatrix} a & b \\ c & d \end{pmatrix}") }}

```jinja2
{{/* math(content="\begin{pmatrix} a & b \\ c & d \end{pmatrix}") */}}
```
