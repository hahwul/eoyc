+++
title = "Alert"
weight = 1
+++

Display different types of alert messages to highlight important information, statuses, or warnings.

## Info

{% alert_info() %}
  Info alert
{% end %}

```jinja2
{%/* alert_info() */%}
  Info alert
{%/* end */%}
```

## Success

{% alert_success() %}
  Success alert
{% end %}

```jinja2
{%/* alert_success() */%}
  Success alert
{%/* end */%}
```

## Warning

{% alert_warning() %}
  Warning alert
{% end %}

```jinja2
{%/* alert_warning() */%}
  Warning alert
{%/* end */%}
```

## Error

{% alert_error() %}
  Error alert
{% end %}

```jinja2
{%/* alert_error() */%}
  Error alert
{%/* end */%}
```