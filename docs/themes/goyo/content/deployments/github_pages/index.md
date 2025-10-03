+++
title = "Github"
description = "Deploying to GitHub Pages"
weight = 1
template = "page.html"
+++

GitHub Pages is a feature that hosts static websites directly from a GitHub repository. You can use it to easily deploy your Zola site to the web for free.

## GitHub Actions

First, create a GitHub Workflow file in your repository (e.g., `./.github/workflows/deploy.yml`).

Add the following content to the file. If you need a **Personal Access Token (PAT)** for deployment, you can generate one from **Settings > Developer settings > Personal access tokens**. Once you have the token, add it as a secret in your repository's settings. In the example below, the secret is named `TOKEN`.

```yaml
on: push
name: Build and deploy GH Pages
jobs:
  build:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: checkout
        uses: actions/checkout@v4
      - name: build_and_deploy
        uses: shalzz/zola-deploy-action@master
        env:
          # Target branch
          PAGES_BRANCH: gh-pages
          # Provide personal access token
          TOKEN: ${{ secrets.TOKEN }}
          # Or if publishing to the same repo, use the automatic token
          #TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

This workflow triggers on every `push` to the `main` branch, automatically building and deploying your Zola website.

## Manual Deployment to the `gh-pages` Branch

Instead of using GitHub Actions, you can also build the site locally and deploy by pushing directly to the `gh-pages` branch.

1. Run `zola build` from your project's root directory.
2. Push the contents of the `public` directory to the `gh-pages` branch of your repository.
3. In your repository's **Settings**, navigate to the **Pages** tab. Under "Build and deployment," select **Deploy from a branch**. Choose the `gh-pages` branch and the `/(root)` folder. The contents of this branch will then be published to the web.
