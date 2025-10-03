+++
title = "Creating a Content"
description = "Learn how to create a page with Goyo."
weight = 2
+++

Zola creates and manages documents in the `content` subdirectory. Goyo automatically configures the sidebar based on the structure within `content`. Let's create a simple page to get started.

## Page

First, let's create a page.

```bash
mkdir ./content/hello_world

echo '+++
title = "Hello World"
weight = 1
sort_by = "weight"

[extra]
+++' > ./content/hello_world/index.md
```

[http://localhost:1111/hello-world](http://localhost:1111/hello-world)

## Section

Next, let's create a section. A section is a page that holds multiple other pages. We'll create first and second pages under a list section.

```bash
mkdir ./content/list
mkdir ./content/list/first
mkdir ./content/list/second

echo '+++
title = "List"
weight = 1
sort_by = "weight"

[extra]
+++' > ./content/list/_index.md

echo '+++
title = "First"
weight = 1
sort_by = "weight"

[extra]
+++' > ./content/list/first/index.md

echo '+++
title = "Second"
weight = 2
sort_by = "weight"

[extra]
+++' > ./content/list/second/index.md
```

You can continue to build your structured documentation in this manner.
