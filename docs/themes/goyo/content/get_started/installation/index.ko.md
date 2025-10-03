+++
title = "설치하기"
description = "Goyo를 설치하고 시작하는 방법을 알아보세요."
weight = 1
sort_by = "weight"

[extra]
+++

Goyo 테마는 Zola에서 동작하는 테마입니다. 문서를 사용하기 위해선 Zola 설치가 필요합니다. 여러 OS에 대해 아래와 같이 간단한 방법으로 설치할 수 있습니다.

```bash
# macOS Example
brew install zola
```

자세한 내용은 Zola 공식 웹 페이지의 [설치 문서](https://www.getzola.org/documentation/getting-started/installation/)를 참고해주세요.

zola를 설치했다면 아래와 같이 zola app을 생성합니다.

```bash
zola init your-docs
cd docs
```

그리고 이제 `zola serve` 명령을 통해 웹 페이지를 구동할 수 있고 `http://localhost:1111` 로 접근하여 확인할 수 있습니다.

## Install Goyo Theme

Zola에서 테마를 설치하는 가장 쉬운 방법은 zola 프로젝트의 themes 하위 디렉토리에 clone 또는 submodule로 연결하는 방법입니다.

Clone 예시

```bash
git clone https://github.com/hahwul/goyo themes/goyo
```

Submodule 예시

```bash
git add submodule https://github.com/hahwul/goyo themes/goyo
```

## Goyo 테마 업데이트

Goyo 테마를 최신 버전으로 업데이트하려면 아래 방법을 사용할 수 있습니다.

- clone으로 설치한 경우:
  ```bash
  cd themes/goyo
  git pull
  ```

- submodule로 설치한 경우:
  ```bash
  git submodule sync
  git submodule update --remote
  ```

최신 Goyo 테마의 기능과 버그 수정 사항을 적용할 수 있습니다.

## Set theme in config.toml

마지막 단계입니다. config.toml에서 theme를 작성하여 goyo 테마를 사용하도록 합니다.


```toml
title = "Your App"
theme = "goyo"
```

이제 zola 실행 시 goyo 테마로 동작합니다.

```bash
zola serve
```

다만 아직 컨텐츠가 없기 떄문에 영롱한 색상의 빈 페이지만 확인됩니다. 다음 문서에서 첫 페이지를 만들어봅니다.
