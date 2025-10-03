+++
title = "Github"
description = "GitHub Pages에 배포하기"
weight = 1
template = "page.html"
+++

GitHub Pages는 GitHub 저장소에서 정적 웹사이트를 호스팅하는 기능입니다. 이를 이용하면 Zola 사이트를 웹에 무료로 쉽게 배포할 수 있습니다.

## Github Action

저장 소 내 Github Workflow를 생성합니다. (e.g., `./github/workflows/deploy.yaml`)

그리고 아래 내용을 작성합니다. 이 때 배포를 위해서 PAT(Personal Access Token)이 필요하면 설정(설정 > 개발자 설정 > 개인 액세스 토큰)에서 발급한 후 저장소 내 Secret 에 값을 추가합니다. 아래 예시 기준으론 `TOKEN` 입니다.

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

위 workflow는 push 시 동작하며 push 이벤트가 발생함과 동시에 Zola 웹 페이지를 빌드하여 배포합니다.

## gh-pages 브랜치로 수동 배포

GitHub Actions를 사용하지 않고 로컬에서 빌드 후 `gh-pages` 브랜치에 직접 푸시하여 배포할 수도 있습니다.

1. 문서 루트에서 `zola build` 를 실행합니다.
2. public 디렉토리 내용을 `gh-pages` 브랜치에 푸시합니다.
3. 저장소 설정에서 Page로 진입한 후 `Deploy from a branch`를 선택하고 `gh-pages` 브랜치와 `/ (root)` 폴더를 선택하면 해당 디렉토리 내용이 웹에 게시됩니다.
