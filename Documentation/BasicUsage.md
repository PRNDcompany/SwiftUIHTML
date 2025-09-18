# 기본 사용법 / Basic Usage

SwiftUIHTML의 기본적인 사용 방법을 소개합니다.
This guide introduces the basic usage of SwiftUIHTML.

## 1. 간단한 HTML 렌더링 / Simple HTML Rendering

### 한글 설명
가장 기본적인 HTML 렌더링 예제입니다. HTMLView를 생성하고 파서를 지정하면 됩니다.

### English
The most basic HTML rendering example. Simply create an HTMLView and specify a parser.

```swift
import SwiftUI
import SwiftUIHTML

struct SimpleHTMLView: View {
    let html = """
        <h1>안녕하세요!</h1>
        <p>이것은 <strong>SwiftUIHTML</strong> 라이브러리입니다.</p>
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .default)
    }
}
```

## 2. 텍스트 스타일링 / Text Styling

### 한글 설명
다양한 텍스트 스타일을 적용하는 방법입니다. 볼드, 이탤릭, 언더라인 등을 사용할 수 있습니다.

### English
How to apply various text styles. You can use bold, italic, underline, and more.

```swift
struct TextStyleExample: View {
    let html = """
        <p>
            일반 텍스트와 <b>볼드 텍스트</b>, 
            <i>이탤릭 텍스트</i>, 
            <u>밑줄 텍스트</u>를 함께 사용할 수 있습니다.
        </p>
        <p>
            <strong>strong 태그</strong>와 <em>em 태그</em>도 지원합니다.
        </p>
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .default)
            .htmlEnvironment(\.styleContainer, {
                var container = HTMLStyleContainer()
                container.uiFont = .systemFont(ofSize: 16)
                return container
            }())
    }
}
```

## 3. 이미지 삽입 / Image Embedding

### 한글 설명
HTML 내에 이미지를 삽입하는 방법입니다. 웹 URL이나 로컬 이미지를 모두 지원합니다.

### English
How to embed images in HTML. Both web URLs and local images are supported.

```swift
struct ImageExample: View {
    let html = """
        <h2>이미지 예제</h2>
        <p>텍스트와 함께 이미지를 표시합니다:</p>
        <img src="https://picsum.photos/200/150" width="200" height="150" />
        <p>이미지 아래 텍스트입니다.</p>
        
        <p>인라인 이미지도 가능합니다: 
        <img src="https://picsum.photos/20/20" width="20" height="20" /> 
        텍스트 중간에 삽입됩니다.</p>
        """
    
    var body: some View {
        ScrollView {
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .padding()
        }
    }
}
```

## 4. 링크 처리 / Link Handling

### 한글 설명
클릭 가능한 링크를 생성하는 방법입니다. 링크 태그는 자동으로 처리됩니다.

### English
How to create clickable links. Link tags are automatically handled.

```swift
struct LinkExample: View {
    let html = """
        <h2>링크 예제</h2>
        <p>
            웹사이트 링크: <a href="https://www.apple.com">Apple 홈페이지</a>
        </p>
        <p>
            이메일 링크: <a href="mailto:example@email.com">이메일 보내기</a>
        </p>
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .default)
    }
}
```

## 5. 블록 요소 구조 / Block Element Structure

### 한글 설명
다양한 블록 요소들을 사용하는 방법입니다. div, p, section 등의 기본 블록 태그를 활용합니다.

### English
How to use various block elements. Utilize basic block tags like div, p, section, etc.

```swift
struct BlockElementExample: View {
    let html = """
        <div>
            <h1>메인 제목</h1>
            <p>첫 번째 단락입니다.</p>
            <p>두 번째 단락입니다.</p>
        </div>
        
        <section>
            <h2>섹션 제목</h2>
            <div style="background-color: #f0f0f0; padding: 10px;">
                <p>배경색이 있는 div 안의 단락입니다.</p>
                <p>여러 단락을 포함할 수 있습니다.</p>
            </div>
        </section>
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .default)
            .padding()
    }
}
```

## 6. 헤더와 섹션 구조 / Headers and Section Structure

### 한글 설명
HTML 문서 구조를 만드는 방법입니다. header, main, section, footer 태그를 활용합니다.

### English
How to create HTML document structure using header, main, section, and footer tags.

```swift
struct DocumentStructureExample: View {
    let html = """
        <header>
            <h1>SwiftUIHTML 문서</h1>
            <p>강력한 HTML 렌더링 라이브러리</p>
        </header>
        
        <main>
            <section>
                <h2>첫 번째 섹션</h2>
                <p>이것은 첫 번째 섹션의 내용입니다.</p>
            </section>
            
            <section>
                <h2>두 번째 섹션</h2>
                <p>이것은 두 번째 섹션의 내용입니다.</p>
                <p>여러 단락을 포함할 수 있습니다.</p>
            </section>
        </main>
        
        <footer>
            <p>© 2025 SwiftUIHTML. All rights reserved.</p>
        </footer>
        """
    
    var body: some View {
        ScrollView {
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .padding()
        }
    }
}
```

## 7. 줄바꿈 처리 / Line Break Handling

### 한글 설명
텍스트 줄바꿈을 처리하는 방법입니다. br 태그와 줄바꿈 모드를 설정할 수 있습니다.

### English
How to handle text line breaks. You can use br tags and configure line break modes.

```swift
struct LineBreakExample: View {
    let html = """
        <h2>줄바꿈 예제</h2>
        <p>
            첫 번째 줄입니다.<br>
            두 번째 줄입니다.<br>
            세 번째 줄입니다.
        </p>
        
        <p>
            긴 텍스트는 자동으로 줄바꿈됩니다. 
            이것은 매우 긴 문장으로 화면 너비를 초과하면 자동으로 다음 줄로 넘어갑니다. 
            줄바꿈 모드를 설정하여 단어 단위 또는 문자 단위로 줄바꿈을 제어할 수 있습니다.
        </p>
        """
    
    var body: some View {
        VStack(spacing: 20) {
            // 단어 단위 줄바꿈
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    container.lineBreakMode = .byWordWrapping
                    return container
                }())
                .border(Color.blue)
            
            // 문자 단위 줄바꿈
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    container.lineBreakMode = .byCharWrapping
                    return container
                }())
                .border(Color.green)
        }
        .padding()
    }
}
```

## 8. 폰트 설정 / Font Configuration

### 한글 설명
폰트 크기와 스타일을 설정하는 방법입니다. UIFont를 사용하여 시스템 폰트나 커스텀 폰트를 적용할 수 있습니다.

### English
How to configure font size and style. You can apply system fonts or custom fonts using UIFont.

```swift
struct FontExample: View {
    let html = """
        <h1>큰 제목</h1>
        <h2>중간 제목</h2>
        <h3>작은 제목</h3>
        <p>일반 텍스트입니다.</p>
        <p style="font-family: 'Helvetica';">Helvetica 폰트를 사용한 텍스트</p>
        """
    
    var body: some View {
        VStack(spacing: 20) {
            // 기본 폰트 크기
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    container.uiFont = .systemFont(ofSize: 14)
                    return container
                }())
            
            Divider()
            
            // 큰 폰트 크기
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    container.uiFont = .systemFont(ofSize: 18)
                    return container
                }())
        }
        .padding()
    }
}
```

## 9. 줄 높이 설정 / Line Height Configuration

### 한글 설명
텍스트 줄 높이를 조정하는 방법입니다. 가독성을 높이기 위해 줄 간격을 설정할 수 있습니다.

### English
How to adjust text line height. You can set line spacing to improve readability.

```swift
struct LineHeightExample: View {
    let html = """
        <p>
            이것은 여러 줄로 구성된 단락입니다.
            줄 높이를 조정하면 텍스트 간격이 변경됩니다.
            가독성을 높이기 위해 적절한 줄 높이를 설정하세요.
        </p>
        """
    
    var body: some View {
        VStack(spacing: 20) {
            // 좁은 줄 간격
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    let font = UIFont.systemFont(ofSize: 14)
                    container.uiFont = font
                    container.textLine = .lineHeight(font: font, lineHeight: 18)
                    return container
                }())
                .border(Color.red)
            
            // 넓은 줄 간격
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    let font = UIFont.systemFont(ofSize: 14)
                    container.uiFont = font
                    container.textLine = .lineHeight(font: font, lineHeight: 28)
                    return container
                }())
                .border(Color.blue)
        }
        .padding()
    }
}
```

## 10. 복합 예제 / Complex Example

### 한글 설명
여러 기능을 함께 사용하는 복합 예제입니다.

### English
A complex example using multiple features together.

```swift
struct ComplexExample: View {
    let html = """
        <header style="background-color: #f0f0f0; padding: 20px;">
            <h1 style="color: #333;">SwiftUIHTML 데모</h1>
            <p style="color: #666;">다양한 기능을 한 번에 보여주는 예제</p>
        </header>
        
        <main style="padding: 20px;">
            <section>
                <h2>텍스트 스타일</h2>
                <p>
                    <b>볼드</b>, <i>이탤릭</i>, <u>밑줄</u>, 
                    <span style="color: red;">빨간색</span>, 
                    <span style="background-color: yellow;">노란 배경</span>
                </p>
            </section>
            
            <section>
                <h2>이미지와 링크</h2>
                <p>
                    <img src="https://picsum.photos/50/50" width="50" height="50" />
                    이미지와 <a href="https://github.com">GitHub 링크</a>
                </p>
            </section>
            
            <section style="border: 1px solid #ddd; padding: 10px; border-radius: 5px;">
                <h2>중첩된 블록 요소</h2>
                <div>
                    <p>• 첫 번째 항목</p>
                    <p>• 두 번째 항목 with <strong>강조</strong></p>
                    <p>• 세 번째 항목</p>
                </div>
            </section>
        </main>
        
        <footer style="background-color: #333; color: white; padding: 10px;">
            <p>© 2025 Example Footer</p>
        </footer>
        """
    
    var body: some View {
        ScrollView {
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    let font = UIFont.systemFont(ofSize: 16)
                    container.uiFont = font
                    container.textLine = .lineHeight(font: font, lineHeight: 24)
                    container.lineBreakMode = .byWordWrapping
                    return container
                }())
                .padding()
        }
    }
}
```