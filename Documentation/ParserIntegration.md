# 파서 통합 / Parser Integration

SwiftUIHTML은 HTMLParserable 프로토콜을 통해 다양한 HTML 파서와 통합할 수 있습니다.
SwiftUIHTML can integrate with various HTML parsers through the HTMLParserable protocol.

## HTMLParserable 프로토콜 / HTMLParserable Protocol

### 한글 설명
모든 파서는 HTMLParserable 프로토콜을 구현해야 합니다. 이 프로토콜은 HTML 문자열을 받아 HTMLNode 구조체를 반환하는 단일 메서드를 요구합니다.

### English
All parsers must implement the HTMLParserable protocol. This protocol requires a single method that takes an HTML string and returns an HTMLNode structure.

```swift
protocol HTMLParserable {
    func parse(html: String) -> HTMLNode
}
```

### HTMLNode 구조 / HTMLNode Structure

```swift
struct HTMLNode {
    let tag: String
    let attributes: [String: String]
    let children: [HTMLChild]
}

enum HTMLChild {
    case text(String)
    case trimmingText(String)
    case newLine
    case node(HTMLNode)
}
```

---

## 1. Fuzi 파서 통합 / Fuzi Parser Integration

### 한글 설명
Fuzi는 Swift용 XML/HTML 파서입니다. libxml2를 기반으로 하며 빠른 파싱 성능을 제공합니다.

### English
Fuzi is an XML/HTML parser for Swift. Based on libxml2, it provides fast parsing performance.

### 설치 / Installation

```swift
dependencies: [
    .package(url: "https://github.com/cezheng/Fuzi.git", from: "3.0.0")
]
```

### 구현 / Implementation

```swift
import Fuzi
import SwiftUIHTML

struct HTMLFuziParser: HTMLParserable {
    func parse(html: String) -> HTMLNode {
        do {
            let document = try HTMLDocument(string: html, encoding: .utf8)
            
            // body 태그를 찾거나 root 사용
            if let body = document.body {
                return try elementToHTMLNode(element: body)
            } else if let root = document.root {
                return try elementToHTMLNode(element: root)
            } else {
                return createErrorNode("No root element found")
            }
        } catch {
            return createErrorNode("Parse error: \(error.localizedDescription)")
        }
    }
    
    private func elementToHTMLNode(element: Fuzi.XMLElement) throws -> HTMLNode {
        let tag = element.tag ?? "div"
        
        // 속성 변환
        let attributes = element.attributes.reduce(into: [String: String]()) { result, attribute in
            result[attribute.key] = attribute.value
        }
        
        // 자식 노드 변환
        let children: [HTMLChild] = try element.childNodes(ofTypes: [.Element, .Text])
            .compactMap { node -> HTMLChild? in
                if node.type == .Text {
                    let text = node.stringValue
                    return text.isEmpty ? nil : .trimmingText(text)
                } else if let childElement = node.toElement() {
                    // br 태그는 특별 처리
                    if childElement.tag == "br" {
                        return .newLine
                    }
                    return .node(try elementToHTMLNode(element: childElement))
                }
                return nil
            }
        
        return HTMLNode(tag: tag, attributes: attributes, children: children)
    }
    
    private func createErrorNode(_ message: String) -> HTMLNode {
        HTMLNode(tag: "div", attributes: [:], children: [.text(message)])
    }
}
```

### 사용 예제 / Usage Example

```swift
struct ContentView: View {
    let html = """
        <h1>Fuzi Parser Example</h1>
        <p>This HTML is parsed using <strong>Fuzi</strong>.</p>
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .default)
    }
}
```

---

## 2. SwiftSoup 파서 통합 / SwiftSoup Parser Integration

### 한글 설명
SwiftSoup은 Java의 JSoup을 Swift로 포팅한 HTML 파서입니다. CSS 선택자를 지원하며 HTML 조작이 가능합니다.

### English
SwiftSoup is a Swift port of Java's JSoup HTML parser. It supports CSS selectors and HTML manipulation.

### 설치 / Installation

```swift
dependencies: [
    .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.0.0")
]
```

### 구현 / Implementation

```swift
import SwiftSoup
import SwiftUIHTML

struct HTMLSwiftSoupParser: HTMLParserable {
    func parse(html: String) -> HTMLNode {
        do {
            let document = try SwiftSoup.parse(html)
            
            // body가 있으면 body를, 없으면 전체 document 사용
            if let body = document.body() {
                return try elementToHTMLNode(element: body)
            } else {
                // HTML fragment인 경우
                let wrapper = try document.select("*").first() ?? document
                return try elementToHTMLNode(element: wrapper)
            }
        } catch {
            return createErrorNode("Parse error: \(error.localizedDescription)")
        }
    }
    
    private func elementToHTMLNode(element: SwiftSoup.Element) throws -> HTMLNode {
        let tag = element.tagName()
        
        // 속성 변환
        let attributes = element.getAttributes()?.reduce(into: [String: String]()) { result, attribute in
            result[attribute.getKey()] = attribute.getValue()
        } ?? [:]
        
        // 자식 노드 변환
        let children: [HTMLChild] = try element.getChildNodes().compactMap { node in
            if let textNode = node as? TextNode {
                let text = textNode.text()
                return text.isEmpty ? nil : .trimmingText(text)
            } else if let elementNode = node as? Element {
                // br 태그는 특별 처리
                if elementNode.tagName() == "br" {
                    return .newLine
                }
                return .node(try elementToHTMLNode(element: elementNode))
            }
            return nil
        }
        
        return HTMLNode(tag: tag, attributes: attributes, children: children)
    }
    
    private func createErrorNode(_ message: String) -> HTMLNode {
        HTMLNode(tag: "div", attributes: [:], children: [.text(message)])
    }
}
```

### 사용 예제 / Usage Example

```swift
struct ContentView: View {
    let html = """
        <div class="container">
            <h1>SwiftSoup Parser</h1>
            <p id="description">Parsed with <em>SwiftSoup</em></p>
        </div>
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLSwiftSoupParser())
            .htmlEnvironment(\.configuration, .default)
    }
}
```

---

## 3. 커스텀 파서 구현 / Custom Parser Implementation

### 한글 설명
특별한 요구사항이 있다면 직접 파서를 구현할 수 있습니다.

### English
You can implement your own parser for special requirements.

### 간단한 정규식 기반 파서 / Simple Regex-based Parser

```swift
struct SimpleHTMLParser: HTMLParserable {
    func parse(html: String) -> HTMLNode {
        // 간단한 태그 매칭 (실제 사용에는 부적합, 예제용)
        var children: [HTMLChild] = []
        
        // 텍스트만 추출하는 간단한 예제
        let textOnly = html
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !textOnly.isEmpty {
            children.append(.text(textOnly))
        }
        
        return HTMLNode(tag: "div", attributes: [:], children: children)
    }
}
```

### 고급 커스텀 파서 / Advanced Custom Parser

```swift
struct AdvancedHTMLParser: HTMLParserable {
    func parse(html: String) -> HTMLNode {
        // HTML 전처리
        let processedHTML = preprocessHTML(html)
        
        // 파싱 로직
        let rootNode = parseNode(from: processedHTML)
        
        // 후처리
        return postprocessNode(rootNode)
    }
    
    private func preprocessHTML(_ html: String) -> String {
        // HTML 정규화, 특수 문자 처리 등
        return html
            .replacingOccurrences(of: "&nbsp;", with: " ")
            .replacingOccurrences(of: "&lt;", with: "<")
            .replacingOccurrences(of: "&gt;", with: ">")
            .replacingOccurrences(of: "&amp;", with: "&")
    }
    
    private func parseNode(from html: String) -> HTMLNode {
        // 실제 파싱 로직 구현
        // 태그, 속성, 자식 노드 추출
        
        // 예제: 기본 구조 반환
        return HTMLNode(
            tag: "div",
            attributes: [:],
            children: [.text(html)]
        )
    }
    
    private func postprocessNode(_ node: HTMLNode) -> HTMLNode {
        // 노드 정리, 최적화 등
        return node
    }
}
```

---

## 4. 파서 선택 가이드 / Parser Selection Guide

### 한글 가이드

| 파서 | 장점 | 단점 | 추천 사용 케이스 |
|-----|------|------|-----------------|
| **Fuzi** | • 빠른 성능<br>• 메모리 효율적<br>• libxml2 기반 안정성 | • 추가 의존성<br>• 설정 복잡도 | 대용량 HTML 처리 |
| **SwiftSoup** | • 순수 Swift<br>• CSS 선택자<br>• HTML 조작 기능 | • 상대적으로 느림<br>• 메모리 사용량 많음 | HTML 조작이 필요한 경우 |
| **Custom** | • 완전한 제어<br>• 특수 요구사항 대응 | • 개발 시간<br>• 유지보수 부담 | 특별한 파싱 규칙이 필요한 경우 |

### English Guide

| Parser | Pros | Cons | Recommended Use Case |
|--------|------|------|---------------------|
| **Fuzi** | • Fast performance<br>• Memory efficient<br>• libxml2 stability | • Additional dependency<br>• Setup complexity | Large HTML processing |
| **SwiftSoup** | • Pure Swift<br>• CSS selectors<br>• HTML manipulation | • Relatively slow<br>• High memory usage | When HTML manipulation needed |
| **Custom** | • Full control<br>• Special requirements | • Development time<br>• Maintenance burden | Special parsing rules needed |

---

## 5. 파서 최적화 팁 / Parser Optimization Tips

### 한글
1. **캐싱**: 동일한 HTML을 반복 파싱하지 않도록 결과를 캐싱
2. **비동기 처리**: 큰 HTML은 백그라운드에서 파싱
3. **부분 파싱**: 필요한 부분만 선택적으로 파싱
4. **에러 처리**: 파싱 실패 시 적절한 폴백 제공

### English
1. **Caching**: Cache results to avoid re-parsing same HTML
2. **Async Processing**: Parse large HTML in background
3. **Partial Parsing**: Selectively parse only needed parts
4. **Error Handling**: Provide appropriate fallback on parse failure

### 캐싱 예제 / Caching Example

```swift
class CachedHTMLParser: HTMLParserable {
    private var cache: [String: HTMLNode] = [:]
    private let baseParser: HTMLParserable
    
    init(baseParser: HTMLParserable) {
        self.baseParser = baseParser
    }
    
    func parse(html: String) -> HTMLNode {
        // 캐시 확인
        if let cached = cache[html] {
            return cached
        }
        
        // 파싱 및 캐싱
        let node = baseParser.parse(html: html)
        cache[html] = node
        
        // 캐시 크기 제한 (옵션)
        if cache.count > 100 {
            cache.removeAll()
        }
        
        return node
    }
}

// 사용
let cachedParser = CachedHTMLParser(baseParser: HTMLFuziParser())
```

### 비동기 파싱 / Async Parsing

```swift
@MainActor
class AsyncHTMLViewModel: ObservableObject {
    @Published var node: HTMLNode?
    @Published var isLoading = false
    
    func parseHTML(_ html: String, parser: HTMLParserable) async {
        isLoading = true
        
        // 백그라운드에서 파싱
        let node = await Task.detached {
            parser.parse(html: html)
        }.value
        
        // 메인 스레드에서 업데이트
        self.node = node
        self.isLoading = false
    }
}
```

---

## 6. 문제 해결 / Troubleshooting

### 한글

**문제: 특수 문자가 제대로 표시되지 않음**
- 해결: HTML 엔티티를 디코딩하도록 파서 수정

**문제: 중첩된 태그가 제대로 파싱되지 않음**
- 해결: 재귀적 파싱 로직 확인

**문제: 파싱 성능이 느림**
- 해결: 캐싱 적용, 불필요한 태그 필터링

### English

**Issue: Special characters not displayed correctly**
- Solution: Modify parser to decode HTML entities

**Issue: Nested tags not parsed correctly**
- Solution: Check recursive parsing logic

**Issue: Slow parsing performance**
- Solution: Apply caching, filter unnecessary tags

### HTML 엔티티 디코딩 / HTML Entity Decoding

```swift
extension String {
    func decodingHTMLEntities() -> String {
        var result = self
        result = result.replacingOccurrences(of: "&nbsp;", with: " ")
        result = result.replacingOccurrences(of: "&lt;", with: "<")
        result = result.replacingOccurrences(of: "&gt;", with: ">")
        result = result.replacingOccurrences(of: "&quot;", with: "\"")
        result = result.replacingOccurrences(of: "&#39;", with: "'")
        result = result.replacingOccurrences(of: "&amp;", with: "&")
        return result
    }
}
```