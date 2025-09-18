# 커스텀 태그 / Custom Tags

SwiftUIHTML에서 커스텀 태그를 만들고 등록하는 방법을 소개합니다.
This guide introduces how to create and register custom tags in SwiftUIHTML.

## 태그 타입 / Tag Types

### 한글 설명
SwiftUIHTML은 세 가지 타입의 태그를 지원합니다:
- **BlockTag**: 블록 레벨 요소 (div, section, header 등)
- **InlineTag**: 인라인 텍스트 요소 (span, strong, em 등) 
- **InlineAttachmentTag**: 인라인 첨부 요소 (img, video 등)

### English
SwiftUIHTML supports three types of tags:
- **BlockTag**: Block-level elements (div, section, header, etc.)
- **InlineTag**: Inline text elements (span, strong, em, etc.)
- **InlineAttachmentTag**: Inline attachment elements (img, video, etc.)

## 1. 커스텀 블록 태그 / Custom Block Tag

### 한글 설명
h3 태그를 위한 커스텀 블록 태그를 만드는 예제입니다.

### English
Example of creating a custom block tag for h3 element.

```swift
import SwiftUI
import SwiftUIHTML

struct Headinglevel3TagView: BlockTag {
    let element: BlockElement
    
    init(element: BlockElement) {
        self.element = element
    }
    
    var body: some View {
        HTMLBlock(element: element)
            .font(.system(size: 18, weight: .semibold))
            .padding(.vertical, 8)
    }
}

// Configuration에 등록
let configuration = HTMLConfiguration.default
    .register(tag: "h3", renderer: Headinglevel3TagView.self)
```

## 2. 커스텀 헤더 태그 / Custom Header Tag

### 한글 설명
header 태그에 특별한 스타일을 적용하는 커스텀 구현입니다.

### English
Custom implementation that applies special styling to header tags.

```swift
struct HeaderTagView: BlockTag {
    let element: BlockElement
    
    init(element: BlockElement) {
        self.element = element
    }
    
    var body: some View {
        HTMLBlock(element: element)
            .background(Color.gray.opacity(0.1))
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
    }
}

// 사용 예제
let configuration = HTMLConfiguration.default
    .register(tag: "header", renderer: HeaderTagView.self)

let html = """
    <header>
        <h1>앱 제목</h1>
        <p>앱 설명</p>
    </header>
    """
```

## 3. UL 리스트 태그 / UL List Tag

### 한글 설명
ul 태그를 처리하는 커스텀 블록 태그입니다. 기본적으로 ul은 지원되지 않으므로 커스텀으로 구현해야 합니다.

### English
Custom block tag for handling ul tags. Since ul is not supported by default, it needs custom implementation.

```swift
struct ULTagView: BlockTag {
    let element: BlockElement
    
    init(element: BlockElement) {
        self.element = element
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(element.children.indices, id: \.self) { index in
                if case let .node(node) = element.children[index], 
                   node.tag == "li" {
                    HStack(alignment: .top, spacing: 8) {
                        Text("•")
                            .font(.system(size: 16))
                        HTMLNodeView(node: node)
                    }
                }
            }
        }
        .padding(.leading, 16)
    }
}

// 사용 예제
let configuration = HTMLConfiguration.default
    .register(tag: "ul", renderer: ULTagView.self)

let html = """
    <ul>
        <li>첫 번째 항목</li>
        <li>두 번째 항목</li>
        <li>세 번째 항목</li>
    </ul>
    """
```

## 4. 비디오 태그 / Video Tag

### 한글 설명
AVPlayer를 사용하여 비디오를 재생하는 커스텀 태그입니다.

### English
Custom tag that plays videos using AVPlayer.

```swift
import AVKit

struct VideoTagView: BlockTag, Equatable {
    static func == (lhs: VideoTagView, rhs: VideoTagView) -> Bool {
        lhs.element == rhs.element
    }
    
    @MainActor
    final class Context: ObservableObject {
        private var player: AVPlayer?
        private var videoURL: URL?
        @Published var ratio: CGFloat = 1
        
        func player(url: URL?) -> AVPlayer? {
            guard let url else { return nil }
            guard videoURL != url else { return player }
            
            let _player = AVPlayer(url: url)
            videoURL = url
            player = _player
            _player.play()
            
            return player
        }
    }
    
    let element: BlockElement
    let url: URL?
    @StateObject var context = Context()
    
    init(element: BlockElement) {
        self.element = element
        self.url = element.attributes["src"]?.url
    }
    
    var body: some View {
        if let player = context.player(url: url) {
            VideoPlayer(player: player)
                .aspectRatio(context.ratio, contentMode: .fit)
                .frame(height: 200)
        }
    }
}

// 사용 예제
let configuration = HTMLConfiguration.default
    .register(tag: "video", renderer: VideoTagView.self)

let html = """
    <video src="https://example.com/video.mp4" />
    """
```

## 5. 커스텀 인라인 태그 / Custom Inline Tag

### 한글 설명
텍스트를 하이라이트하는 커스텀 인라인 태그를 만듭니다.

### English
Create a custom inline tag that highlights text.

```swift
struct HighlightTag: InlineTag {
    static func applyStyles(
        with attributes: [String: AttributeValue],
        to styleContainer: inout HTMLStyleContainer
    ) {
        // 노란색 배경 적용
        styleContainer.backgroundColor = .yellow.withAlphaComponent(0.3)
        
        // 속성에서 색상 지정 가능
        if let colorValue = attributes["color"]?.string {
            styleContainer.foregroundColor = Color(hex: colorValue)
        }
    }
}

// 사용 예제
let configuration = HTMLConfiguration.default
    .register(tag: "mark", renderer: HighlightTag.self)
    .register(tag: "highlight", renderer: HighlightTag.self)

let html = """
    <p>이것은 <mark>하이라이트된</mark> 텍스트입니다.</p>
    <p>커스텀 <highlight color="#ff0000">빨간색 하이라이트</highlight>도 가능합니다.</p>
    """
```

## 6. 코드 블록 태그 / Code Block Tag

### 한글 설명
코드를 표시하는 커스텀 블록 태그입니다.

### English
Custom block tag for displaying code.

```swift
struct CodeBlockTag: BlockTag {
    let element: BlockElement
    
    init(element: BlockElement) {
        self.element = element
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            Text(element.text)
                .font(.system(.body, design: .monospaced))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .textSelection(.enabled)
        }
        .frame(maxWidth: .infinity)
    }
}

// pre 태그와 code 태그 모두 등록
let configuration = HTMLConfiguration.default
    .register(tag: "pre", renderer: CodeBlockTag.self)
    .register(tag: "code", renderer: CodeBlockTag.self)
```

## 7. 태그 등록과 제거 / Tag Registration and Removal

### 한글 설명
태그를 동적으로 등록하고 제거하는 방법입니다.

### English
How to dynamically register and remove tags.

```swift
// 여러 태그 한 번에 등록
let configuration = HTMLConfiguration.default
    .register(tag: "h3", "h4", "h5", "h6", renderer: HeadingTag.self)
    .register(tag: "mark", "highlight", renderer: HighlightTag.self)

// 특정 태그 제거
let modifiedConfig = configuration
    .remove(tag: "h6")  // h6 태그 제거

// 모든 태그 제거 후 재등록
let cleanConfig = HTMLConfiguration()
    .removeAll()  // 모든 기본 태그 제거
    .register(tag: "div", renderer: MyCustomDivTag.self)
    .register(tag: "p", renderer: MyCustomParagraphTag.self)
```

## 8. AttributeStyler 사용 / Using AttributeStyler

### 한글 설명
전역 스타일 처리를 위한 AttributeStyler를 구현합니다.

### English
Implement AttributeStyler for global style processing.

```swift
struct MyCustomAttributeStyler: AttributeStyleable {
    func applyStyles(
        attributes: [String: AttributeValue],
        to styleContainer: inout HTMLStyleContainer
    ) {
        // 모든 요소에 기본 패딩 적용
        if attributes["style"] != nil {
            styleContainer.padding = EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
        }
        
        // data-theme 속성 처리
        if let theme = attributes["data-theme"]?.string {
            switch theme {
            case "dark":
                styleContainer.backgroundColor = .black
                styleContainer.foregroundColor = .white
            case "light":
                styleContainer.backgroundColor = .white
                styleContainer.foregroundColor = .black
            default:
                break
            }
        }
    }
}

// Configuration에 적용
let configuration = HTMLConfiguration.default
    .attributeStyler(MyCustomAttributeStyler())
```

## 9. 복합 커스텀 태그 예제 / Complex Custom Tag Example

### 한글 설명
여러 커스텀 태그를 함께 사용하는 완전한 예제입니다.

### English
Complete example using multiple custom tags together.

```swift
struct ContentView: View {
    let html = """
        <header>
            <h1>커스텀 태그 데모</h1>
            <h3>다양한 커스텀 태그 예제</h3>
        </header>
        
        <main>
            <section>
                <h2>리스트 예제</h2>
                <ul>
                    <li>커스텀 UL 태그</li>
                    <li><mark>하이라이트</mark>된 항목</li>
                </ul>
            </section>
            
            <section>
                <h2>코드 예제</h2>
                <code>
                    let message = "Hello, SwiftUIHTML!"
                    print(message)
                </code>
            </section>
            
            <section>
                <h2>비디오</h2>
                <video src="https://example.com/sample.mp4" />
            </section>
        </main>
        """
    
    var body: some View {
        ScrollView {
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, customConfiguration())
                .padding()
        }
    }
    
    func customConfiguration() -> HTMLConfiguration {
        HTMLConfiguration.default
            .register(tag: "h3", renderer: Headinglevel3TagView.self)
            .register(tag: "header", renderer: HeaderTagView.self)
            .register(tag: "ul", renderer: ULTagView.self)
            .register(tag: "mark", "highlight", renderer: HighlightTag.self)
            .register(tag: "code", "pre", renderer: CodeBlockTag.self)
            .register(tag: "video", renderer: VideoTagView.self)
            .attributeStyler(MyCustomAttributeStyler())
    }
}
```

## 팁과 주의사항 / Tips and Considerations

### 한글
- 커스텀 태그는 기본 태그를 덮어쓸 수 있습니다
- BlockTag는 View 프로토콜을 구현해야 합니다
- InlineTag는 스타일만 적용하고 렌더링은 시스템이 처리합니다
- InlineAttachmentTag는 인라인으로 삽입되는 뷰를 생성합니다

### English
- Custom tags can override default tags
- BlockTag must implement the View protocol
- InlineTag only applies styles; rendering is handled by the system
- InlineAttachmentTag creates views that are inserted inline