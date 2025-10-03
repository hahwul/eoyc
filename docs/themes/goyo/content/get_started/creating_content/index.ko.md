+++
title = "콘텐츠 생성하기"
description = "Goyo로 페이지를 만드는 방법을 알아보세요."
weight = 2
+++

Zola는 `content` 하위 디렉토리에서 문서를 생성하고 관리합니다. Goyo는 `content` 내부 구조에 따라서 Sidebar를 자동으로 구성합니다. 그럼 간단한 페이지를 만들어 문서 작업의 시작을 알려봅시다.

## Page

먼저 페이지를 하나 만들어봅니다.

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

이번에는 섹션을 만들어봅니다. 세션은 여러 페이지를 담고 있는 페이지입니다. list 하위에 first, second 란 페이지를 만들어봅니다.

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

이런 형태로 구조화된 문서를 만들어갈 수 있습니다.
