+++
title = "Collapse"
weight = 1
+++

`collapse`

- `collapse`: Shows a collapsible section.  
  Parameters:  
  - `title`: The title of the collapsible section.  
  - `body`: The content inside the collapsible section.

```jinja
{%/* collapse(title="How do I create an account?") */%}
Click the **'Sign Up'** button in the top right corner and follow the registration process.
\
You can also use `markdown` syntax.
{%/* end */%}
```

{% collapse(title="How do I create an account?") %}
Click the **'Sign Up'** button in the top right corner and follow the registration process.
\
You can also use `markdown` syntax.
{% end %}
