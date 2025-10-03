+++
title = "랜딩 페이지 만들기"
description = "Goyo로 현대적이고 기능이 풍부한 랜딩 페이지를 만드는 방법을 알아보세요."
weight = 3
sort_by = "weight"

[extra]
+++

랜딩 페이지는 방문자가 가장 먼저 보게 되는 페이지입니다. Goyo에서는 `landing.html`을 사용하여 제작되며, `content/_index.md`에서 설정합니다. 이를 통해 프로젝트를 위한 풍부하고 매력적인 진입점을 만들 수 있습니다.

다른 언어의 랜딩 페이지를 만들려면, `content/_index.ko.md`와 같이 해당 언어의 파일을 생성하면 됩니다.

## 템플릿 설정

먼저 `_index.md` 파일이 `landing.html` 템플릿을 사용하도록 설정되었는지 확인하세요.

```toml
template = "landing.html"
```

## 전체 설정 예시

Goyo 랜딩 페이지는 `_index.md` 파일의 `[extra]` 섹션을 통해 매우 유연하게 사용자 정의할 수 있습니다. 아래는 사용 가능한 모든 섹션을 보여주는 전체 예시입니다. 필요하지 않은 섹션은 생략할 수 있으며, 그 경우 해당 섹션은 렌더링되지 않습니다.

```toml
+++
template = "landing.html"
title = "Goyo"

[extra]
version = "v0.1.0"

# Hero 섹션
# 페이지 상단의 메인 섹션입니다.
[extra.hero]
title = "Goyo에 오신 것을 환영합니다!"
badge = "✨ Minimalist Documentation Theme"
description = "문서화를 위한 간단하고 깔끔한 Zola 테마입니다."
image = "/images/landing.jpg" # 배경 이미지
cta_buttons = [
    { text = "시작하기", url = "/get-started/installation/", style = "primary" },
    { text = "GitHub에서 보기", url = "https://github.com/your/repo", style = "secondary" },
]

# Features 섹션
# 주요 기능을 그리드 형태로 강조합니다.
[[extra.features]]
title = "문서 친화적"
desc = "깔끔한 문서 작성 경험을 제공합니다."
icon = "fa-solid fa-book"

[[extra.features]]
title = "심플한 디자인"
desc = "미니멀리즘을 추구하는 테마입니다."
icon = "fa-solid fa-minimize"

# Trust 섹션
# 당신을 신뢰하는 회사나 프로젝트의 로고를 보여줍니다.
[extra.trust_section]
title = "최고의 기업들이 신뢰합니다"
logos = [
    { src = "/images/logo1.svg", alt = "Company One" },
    { src = "/images/logo2.svg", alt = "Company Two" },
]

# Social Proof 섹션
# 사용자들의 추천사를 보여줍니다.
[extra.social_proof_section]
title = "사용자들의 평가"
testimonials = [
    {
        author = "Jane Doe",
        role = "TechCorp 개발자",
        quote = "Goyo는 우리의 문서화 프로세스를 완전히 바꾸어 놓았습니다. 간단하고, 우아하며, 믿을 수 없을 정도로 빠릅니다.",
        avatar = "/images/avatars/jane.png"
    },
    {
        author = "John Smith",
        role = "Innovate LLC 프로젝트 관리자",
        quote = "최고의 Zola 문서 테마입니다. 설정이 매우 쉬웠습니다.",
        avatar = "/images/avatars/john.png"
    },
]

# Final Call to Action 섹션
# 푸터 전 사용자에게 마지막으로 행동을 유도하는 섹션입니다.
[extra.final_cta_section]
title = "시작할 준비가 되셨나요?"
description = "오늘 Goyo와 함께 여정을 시작하고 아름다운 문서를 쉽게 만들어보세요."
button = { text = "지금 시작하기", url = "/get-started/installation/" }
image = "/images/contribute.png"
+++
```

## 섹션별 설명

- **`[extra.hero]`**: 메인 배너입니다. `title`, `description`, 전체 화면 배경 `image`, 그리고 클릭 유도 버튼 목록(`cta_buttons`)을 포함합니다. 각 버튼은 `text`, `url`, 그리고 `style`(`primary`는 주 버튼, `secondary`는 보조 버튼)을 가집니다.

- **`[[extra.features]]`**: 그리드에 표시할 기능 목록입니다. 각 기능은 `title`, `desc`(설명), 그리고 [Font Awesome](https://fontawesome.com/)의 `icon`을 가집니다.

- **`[extra.trust_section]`**: 회사나 프로젝트의 로고를 보여줍니다. `logos`는 각 항목이 이미지 `src`와 `alt` 텍스트를 가지는 목록입니다.

- **`[extra.social_proof_section]`**: 사용자 추천사를 표시합니다. `testimonials`는 각 객체가 `author`, `role`, `quote`, `avatar` 이미지를 가지는 목록입니다.

- **`[extra.final_cta_section]`**: `title`, `description`, 그리고 `text`와 `url`을 가진 단일 `button`으로 구성된 마지막 클릭 유도 블록입니다.
    - `image` 필드를 추가하면 CTA 섹션에 이미지를 함께 보여줄 수 있습니다. 예시: `image = "/images/contribute.png"`
