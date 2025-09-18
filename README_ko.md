# SwiftUIHTML

![Platform | iOS](https://img.shields.io/badge/platform-iOS%20%7C%20iPadOS%20%7C%20macOS-orange.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)

**SwiftUIHTML**은 SwiftUI에서 HTML 콘텐츠를 네이티브 뷰로 렌더링하는 강력하고 커스터마이즈 가능한 라이브러리입니다.

[View English Documentation](README.md)

## 데모

![SwiftUIHTML Demo](Screen%20Recording.gif)

---

## 🚀 주요 기능

- **HTML 렌더링**: SwiftUI 환경에서 HTML을 네이티브 뷰로 변환
- **커스텀 태그 시스템**: BlockTag, InlineTag, InlineAttachmentTag 프로토콜로 자유로운 확장
- **CSS 스타일 지원**: 인라인 스타일(padding, margin, background, border 등) 완벽 지원
- **유연한 파서 통합**: Fuzi, SwiftSoup 등 외부 파서 라이브러리와 연동
- **환경 값 시스템**: 전역 설정 관리 및 스타일 커스터마이징

---

## 📋 지원 태그

### 기본 제공 태그

| 카테고리 | 태그 |
|---------|-----|
| **블록** | `div`, `body`, `p`, `header`, `main`, `section`, `footer`, `h1`, `h2` |
| **인라인** | `span`, `a`, `b`, `strong`, `i`, `em`, `u` |
| **첨부** | `img` |

> 참고: h3, ul, video 등의 태그는 커스텀 태그로 등록하여 사용할 수 있습니다.

### CSS 스타일 속성
- **텍스트 스타일**: `color`, `background-color`, `font-family`, `font-size`, `line-height`, `word-break`
- **블록 레이아웃**: `padding`, `margin`, `border`, `border-radius` (div, p, section 등 block 요소만)
- **인라인 스타일**: `color`, `background-color`, `border-radius` (strong, em, span 등 inline 요소)

> **참고**: inline 요소(span, strong, em 등)에서는 `padding`, `margin`이 지원되지 않습니다.

---

## 📦 설치 방법

### Swift Package Manager (SPM)

```swift
dependencies: [
    .package(url: "https://github.com/PRNDcompany/SwiftUIHTML.git", from: "1.0.0"),
],
targets: [
    .target(name: "YourTarget", dependencies: ["SwiftUIHTML"]),
]
```

---

## 🛠️ 빠른 시작

### 기본 사용법

```swift
import SwiftUI
import SwiftUIHTML

struct ContentView: View {
    let html = """
        <h1>안녕하세요, SwiftUIHTML!</h1>
        <p>이것은 <strong>굵은 글씨</strong>와 <em>기울임 글씨</em>가 포함된 단락입니다.</p>
        <img src="https://example.com/image.jpg" width="100" height="100" />
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .default)
            .htmlEnvironment(\.styleContainer, createStyleContainer())
    }
    
    func createStyleContainer() -> HTMLStyleContainer {
        var container = HTMLStyleContainer()
        container.uiFont = .systemFont(ofSize: 16)
        container.lineBreakMode = .byWordWrapping
        return container
    }
}
```

### 파서 구현

HTMLParserable 프로토콜을 구현하여 원하는 HTML 파서를 사용할 수 있습니다:

```swift
struct MyHTMLParser: HTMLParserable {
    func parse(html: String) -> HTMLNode {
        // 파서 구현
    }
}
```

> 📚 **상세 파서 구현 예제**: [Documentation/ParserIntegration.md](Documentation/ParserIntegration.md)

---

## 📚 문서

상세한 사용법과 예제는 Documentation 폴더를 참고하세요:

- 📖 **[기본 사용법](Documentation/BasicUsage.md)** - HTML 렌더링 기초
- 🎨 **[스타일링 가이드](Documentation/Styling.md)** - CSS 스타일과 설정
- 🔧 **[커스텀 태그](Documentation/CustomTags.md)** - 커스텀 태그 만들기
- 🔌 **[파서 통합](Documentation/ParserIntegration.md)** - Fuzi, SwiftSoup 연동
- 🚀 **[고급 기능](Documentation/AdvancedFeatures.md)** - 환경값과 고급 커스터마이징

### 빠른 예제

#### 커스텀 태그 등록

```swift
// 간단한 커스텀 태그 등록
let configuration = HTMLConfiguration.default
    .register(tag: "video", renderer: VideoTag.self)
    .register(tag: "h3", renderer: HeadingLevel3.self)
```

#### CSS 스타일 적용

```swift
let html = """
    <div style="padding: 20px; background-color: #f0f0f0; border-radius: 8px;">
        <h2 style="color: #333;">스타일 예제</h2>
    </div>
    """
```

#### 줄바꿈 모드 설정

```swift
var container = HTMLStyleContainer()
container.lineBreakMode = .byWordWrapping  // 또는 .byCharWrapping
```

---

## 🔍 주요 컴포넌트

### HTMLView
HTML 콘텐츠를 렌더링하는 메인 뷰

### HTMLConfiguration  
태그 렌더러 등록 및 관리

### HTMLStyleContainer
전역 텍스트 스타일 설정

### HTMLParserable
외부 HTML 파서 연동 프로토콜

---

## 📱 예제 프로젝트

더 많은 예제는 `Example` 폴더의 프로젝트를 참고하세요.

---

## 🤝 기여하기

기여를 환영합니다! 이슈나 PR을 자유롭게 제출해주세요.

---

## 📄 라이선스

Copyright © 2025 PRND. All rights reserved.