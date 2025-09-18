# 스타일링 및 설정 / Styling and Configuration

SwiftUIHTML에서 CSS 스타일과 각종 설정을 적용하는 방법을 소개합니다.
This guide introduces how to apply CSS styles and various configurations in SwiftUIHTML.

## 1. CSS 인라인 스타일 / CSS Inline Styles

### 한글 설명
HTML 요소에 직접 CSS 스타일을 적용할 수 있습니다. 지원되는 CSS 속성들을 활용하세요.

### English
You can apply CSS styles directly to HTML elements. Use the supported CSS properties.

### 지원되는 CSS 속성 / Supported CSS Properties

#### 모든 요소 / All Elements
- `color`: 텍스트 색상
- `background-color`: 배경 색상  
- `font-family`: 폰트 패밀리
- `font-size`: 폰트 크기
- `line-height`: 줄 높이
- `word-break`: 단어 줄바꿈 규칙

#### 블록 요소만 / Block Elements Only (div, p, section, etc.)
- `padding`: 내부 여백
- `margin`: 외부 여백
- `border`: 테두리
- `border-radius`: 모서리 둥글기

> **중요**: inline 요소(span, strong, em 등)에서는 `padding`, `margin`이 지원되지 않습니다.  
> **Important**: `padding` and `margin` are not supported for inline elements (span, strong, em, etc.).

```swift
struct CSSStyleExample: View {
    let html = """
        <!-- 색상 스타일 -->
        <p style="color: #FF5733;">빨간색 텍스트</p>
        <p style="background-color: #F0F0F0;">회색 배경</p>
        <p style="color: white; background-color: #333333;">어두운 배경에 흰 텍스트</p>
        
        <!-- 여백 스타일 -->
        <div style="padding: 20px; background-color: #E8F4F8;">
            <p>패딩이 적용된 div</p>
        </div>
        
        <div style="margin: 20px; padding: 10px; background-color: #FFF3E0;">
            <p>마진과 패딩이 모두 적용된 div</p>
        </div>
        
        <!-- 테두리 스타일 -->
        <div style="border: 2px solid #4CAF50; padding: 10px;">
            <p>초록색 테두리</p>
        </div>
        
        <div style="border: 1px solid #ddd; border-radius: 8px; padding: 15px;">
            <p>둥근 모서리 테두리</p>
        </div>
        
        <!-- 복합 스타일 -->
        <div style="background-color: #f5f5f5; border: 1px solid #e0e0e0; border-radius: 12px; padding: 20px; margin: 10px;">
            <h2 style="color: #333; margin-bottom: 10px;">카드 스타일</h2>
            <p style="color: #666;">여러 CSS 속성을 조합한 카드 디자인</p>
        </div>
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

## 2. 폰트 패밀리 설정 / Font Family Configuration

### 한글 설명
CSS font-family 속성으로 폰트를 지정할 수 있습니다. 시스템 폰트나 커스텀 폰트를 사용할 수 있습니다.

### English
You can specify fonts using the CSS font-family property. System fonts or custom fonts can be used.

```swift
struct FontFamilyExample: View {
    let html = """
        <!-- 시스템 폰트 -->
        <p style="font-family: 'Helvetica';">Helvetica 폰트</p>
        <p style="font-family: 'Arial';">Arial 폰트</p>
        <p style="font-family: 'Times New Roman';">Times New Roman 폰트</p>
        
        <!-- 커스텀 폰트 (앱에 추가된 경우) -->
        <p style="font-family: 'SpoqaHanSansNeo-Regular';">스포카 한 산스 Regular</p>
        <p style="font-family: 'SpoqaHanSansNeo-Bold';">스포카 한 산스 Bold</p>
        <p style="font-family: 'SpoqaHanSansNeo-Light';">스포카 한 산스 Light</p>
        
        <!-- 폰트와 다른 스타일 조합 -->
        <p style="font-family: 'Helvetica'; color: #2196F3; background-color: #E3F2FD; padding: 10px;">
            Helvetica 폰트에 색상 스타일 적용
        </p>
        """
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\.configuration, .default)
            .padding()
    }
}
```

## 3. HTMLStyleContainer 설정 / HTMLStyleContainer Configuration

### 한글 설명
HTMLStyleContainer를 통해 전역 텍스트 스타일을 설정할 수 있습니다.

### English
You can set global text styles through HTMLStyleContainer.

```swift
struct StyleContainerExample: View {
    let html = """
        <h1>제목</h1>
        <p>이것은 HTMLStyleContainer 설정이 적용된 단락입니다.</p>
        <p>폰트 크기, 줄 높이, 줄바꿈 모드 등이 전역으로 적용됩니다.</p>
        """
    
    var body: some View {
        VStack(spacing: 30) {
            // 작은 폰트, 좁은 줄 간격
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, smallStyleContainer())
                .border(Color.blue)
            
            // 큰 폰트, 넓은 줄 간격
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, largeStyleContainer())
                .border(Color.green)
        }
        .padding()
    }
    
    func smallStyleContainer() -> HTMLStyleContainer {
        var container = HTMLStyleContainer()
        let font = UIFont.systemFont(ofSize: 12)
        container.uiFont = font
        container.textLine = .lineHeight(font: font, lineHeight: 16)
        container.lineBreakMode = .byWordWrapping
        return container
    }
    
    func largeStyleContainer() -> HTMLStyleContainer {
        var container = HTMLStyleContainer()
        let font = UIFont.systemFont(ofSize: 18)
        container.uiFont = font
        container.textLine = .lineHeight(font: font, lineHeight: 28)
        container.lineBreakMode = .byWordWrapping
        return container
    }
}
```

## 4. 줄 높이와 간격 / Line Height and Spacing

### 한글 설명
TextLine 속성으로 줄 높이나 줄 간격을 세밀하게 조정할 수 있습니다.

### English
You can fine-tune line height or line spacing with the TextLine property.

```swift
struct LineSpacingExample: View {
    let html = """
        <p>
            이것은 여러 줄로 구성된 긴 단락입니다.
            줄 높이를 조정하면 텍스트의 가독성이 변경됩니다.
            적절한 줄 간격은 읽기 편한 텍스트를 만들어줍니다.
            너무 좁거나 너무 넓은 간격은 가독성을 해칩니다.
        </p>
        """
    
    var body: some View {
        VStack(spacing: 20) {
            Text("줄 높이 18pt")
                .font(.caption)
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
            
            Text("줄 높이 24pt")
                .font(.caption)
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    let font = UIFont.systemFont(ofSize: 14)
                    container.uiFont = font
                    container.textLine = .lineHeight(font: font, lineHeight: 24)
                    return container
                }())
                .border(Color.blue)
            
            Text("줄 간격 8pt")
                .font(.caption)
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    container.uiFont = .systemFont(ofSize: 14)
                    container.textLine = .lineSpacing(spacing: 8)
                    return container
                }())
                .border(Color.green)
        }
        .padding()
    }
}
```

## 5. 줄바꿈 모드 / Line Break Mode

### 한글 설명
텍스트가 컨테이너 너비를 초과할 때 줄바꿈 방식을 설정합니다.

### English
Configure how text wraps when it exceeds the container width.

```swift
struct LineBreakModeExample: View {
    let html = """
        <p>
            이것은매우긴단어verylongwordthatwillnotfitonasingleline를포함한텍스트입니다.
            줄바꿈 모드에 따라 다르게 표시됩니다.
        </p>
        <p>
            일반적인 한글 텍스트와 English text를 섞어서 사용할 때도
            줄바꿈 모드가 적용됩니다.
        </p>
        """
    
    var body: some View {
        VStack(spacing: 20) {
            Text("단어 단위 줄바꿈 (byWordWrapping)")
                .font(.caption)
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    container.lineBreakMode = .byWordWrapping
                    container.uiFont = .systemFont(ofSize: 14)
                    return container
                }())
                .frame(width: 250)
                .border(Color.blue)
            
            Text("문자 단위 줄바꿈 (byCharWrapping)")
                .font(.caption)
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    container.lineBreakMode = .byCharWrapping
                    container.uiFont = .systemFont(ofSize: 14)
                    return container
                }())
                .frame(width: 250)
                .border(Color.green)
        }
        .padding()
    }
}
```

## 6. word-break CSS 속성 / word-break CSS Property

### 한글 설명
CSS word-break 속성으로 단어 줄바꿈 규칙을 제어할 수 있습니다.

### English
You can control word breaking rules with the CSS word-break property.

```swift
struct WordBreakExample: View {
    let html = """
        <!-- 기본 -->
        <div style="width: 200px; border: 1px solid #ccc; padding: 10px;">
            <p>Thisissomeverylongwordthatwillnotfitonasingleline and normal text</p>
        </div>
        
        <!-- break-all: 모든 문자에서 줄바꿈 가능 -->
        <div style="width: 200px; border: 1px solid #ccc; padding: 10px; margin-top: 10px;">
            <p style="word-break: break-all;">Thisissomeverylongwordthatwillnotfitonasingleline and normal text</p>
        </div>
        
        <!-- keep-all: 한중일 텍스트에서 단어 단위로만 줄바꿈 -->
        <div style="width: 200px; border: 1px solid #ccc; padding: 10px; margin-top: 10px;">
            <p style="word-break: keep-all;">이것은매우긴한글단어입니다 그리고 일반텍스트</p>
        </div>
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

## 7. 박스 모델 스타일링 / Box Model Styling

### 한글 설명
padding과 margin을 사용한 박스 모델 스타일링 예제입니다.

### English
Box model styling examples using padding and margin.

```swift
struct BoxModelExample: View {
    let html = """
        <!-- 패딩 예제 -->
        <div style="background-color: #FFE0B2; padding: 20px;">
            <p>모든 방향 20px 패딩</p>
        </div>
        
        <div style="background-color: #C8E6C9; padding: 10px 20px;">
            <p>상하 10px, 좌우 20px 패딩</p>
        </div>
        
        <div style="background-color: #B3E5FC; padding: 5px 10px 15px 20px;">
            <p>상 5px, 우 10px, 하 15px, 좌 20px 패딩</p>
        </div>
        
        <!-- 마진 예제 -->
        <div style="background-color: #F8BBD0; margin: 20px; padding: 10px;">
            <p>모든 방향 20px 마진</p>
        </div>
        
        <div style="background-color: #E1BEE7; margin: 10px 30px; padding: 10px;">
            <p>상하 10px, 좌우 30px 마진</p>
        </div>
        
        <!-- 복합 예제 -->
        <div style="margin: 20px; padding: 0;">
            <div style="background-color: #FFCCBC; padding: 15px; margin-bottom: 10px;">
                <p>첫 번째 박스</p>
            </div>
            <div style="background-color: #D7CCC8; padding: 15px;">
                <p>두 번째 박스</p>
            </div>
        </div>
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

## 8. 테두리 스타일링 / Border Styling

### 한글 설명
border와 border-radius를 사용한 테두리 스타일링입니다.

### English
Border styling using border and border-radius properties.

```swift
struct BorderStyleExample: View {
    let html = """
        <!-- 기본 테두리 -->
        <div style="border: 1px solid black; padding: 10px; margin: 10px;">
            <p>1px 검은색 실선 테두리</p>
        </div>
        
        <div style="border: 2px solid #2196F3; padding: 10px; margin: 10px;">
            <p>2px 파란색 실선 테두리</p>
        </div>
        
        <div style="border: 3px solid #4CAF50; padding: 10px; margin: 10px;">
            <p>3px 초록색 실선 테두리</p>
        </div>
        
        <!-- 둥근 모서리 -->
        <div style="border: 1px solid #ddd; border-radius: 4px; padding: 10px; margin: 10px;">
            <p>4px 둥근 모서리</p>
        </div>
        
        <div style="border: 1px solid #ddd; border-radius: 8px; padding: 10px; margin: 10px;">
            <p>8px 둥근 모서리</p>
        </div>
        
        <div style="border: 1px solid #ddd; border-radius: 16px; padding: 10px; margin: 10px;">
            <p>16px 둥근 모서리</p>
        </div>
        
        <!-- 복합 스타일 -->
        <div style="border: 2px solid #FF5722; border-radius: 12px; background-color: #FFF3E0; padding: 15px; margin: 10px;">
            <h2 style="color: #FF5722;">알림 박스</h2>
            <p>테두리, 둥근 모서리, 배경색을 조합한 스타일</p>
        </div>
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

## 9. 복합 스타일 예제 / Complex Style Example

### 한글 설명
여러 CSS 속성을 조합한 실제 사용 예제입니다.

### English
Real-world example combining multiple CSS properties.

```swift
struct ComplexStyleExample: View {
    let html = """
        <!-- 카드 스타일 -->
        <div style="background-color: white; border: 1px solid #e0e0e0; border-radius: 8px; padding: 16px; margin: 16px;">
            <h2 style="color: #333; margin-bottom: 8px;">프로덕트 카드</h2>
            <p style="color: #666; margin-bottom: 12px;">이것은 카드 스타일의 예제입니다.</p>
            <div style="background-color: #f5f5f5; border-radius: 4px; padding: 8px;">
                <p style="color: #999; font-family: 'Helvetica';">추가 정보</p>
            </div>
        </div>
        
        <!-- 알림 배너 -->
        <div style="background-color: #E3F2FD; border: 1px solid #2196F3; border-radius: 4px; padding: 12px; margin: 16px;">
            <p style="color: #1976D2;"><strong>정보:</strong> 이것은 정보 알림입니다.</p>
        </div>
        
        <div style="background-color: #FFF3E0; border: 1px solid #FF9800; border-radius: 4px; padding: 12px; margin: 16px;">
            <p style="color: #F57C00;"><strong>경고:</strong> 이것은 경고 알림입니다.</p>
        </div>
        
        <div style="background-color: #FFEBEE; border: 1px solid #F44336; border-radius: 4px; padding: 12px; margin: 16px;">
            <p style="color: #D32F2F;"><strong>오류:</strong> 이것은 오류 알림입니다.</p>
        </div>
        
        <!-- 인라인 스타일 (span 요소는 margin/padding 지원하지 않음) -->
        <p style="margin: 16px;">
            <span style="background-color: #2196F3; color: white; border-radius: 4px;">기본 버튼</span> 
            <span style="background-color: #4CAF50; color: white; border-radius: 4px;">성공 버튼</span> 
            <span style="background-color: #F44336; color: white; border-radius: 4px;">위험 버튼</span>
        </p>
        """
    
    var body: some View {
        ScrollView {
            HTMLView(html: html, parser: HTMLFuziParser())
                .htmlEnvironment(\.configuration, .default)
                .htmlEnvironment(\.styleContainer, {
                    var container = HTMLStyleContainer()
                    let font = UIFont.systemFont(ofSize: 14)
                    container.uiFont = font
                    container.textLine = .lineHeight(font: font, lineHeight: 20)
                    return container
                }())
                .padding()
        }
    }
}
```

## 10. 스타일 상속 / Style Inheritance

### 한글 설명
부모 요소의 스타일이 자식 요소에 상속되는 방식입니다.

### English
How styles are inherited from parent elements to child elements.

```swift
struct StyleInheritanceExample: View {
    let html = """
        <!-- 부모 스타일이 자식에게 상속 -->
        <div style="color: #2196F3; font-family: 'Helvetica'; padding: 20px; background-color: #E3F2FD;">
            <h2>부모 div의 스타일</h2>
            <p>이 단락은 부모의 color와 font-family를 상속받습니다.</p>
            <div style="background-color: white; padding: 10px;">
                <p>중첩된 div 안의 텍스트도 최상위 부모의 스타일을 상속받습니다.</p>
                <p style="color: #F44336;">이 단락은 자체 color로 덮어씁니다.</p>
            </div>
        </div>
        
        <!-- 상속되지 않는 속성 -->
        <div style="border: 2px solid #4CAF50; padding: 20px; margin: 10px;">
            <p>border, padding, margin은 상속되지 않습니다.</p>
            <div>
                <p>자식 요소는 부모의 border를 상속받지 않습니다.</p>
            </div>
        </div>
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

## 팁과 주의사항 / Tips and Considerations

### 한글
- 모든 CSS 속성이 지원되지는 않습니다. 위에 명시된 속성만 사용하세요.
- HTMLStyleContainer는 전역 설정이므로 모든 요소에 영향을 줍니다.
- 인라인 스타일이 HTMLStyleContainer 설정보다 우선순위가 높습니다.
- 색상은 hex 코드(#RRGGBB) 또는 색상 이름(red, blue 등)을 사용할 수 있습니다.

### English
- Not all CSS properties are supported. Use only the properties listed above.
- HTMLStyleContainer is a global setting that affects all elements.
- Inline styles have higher priority than HTMLStyleContainer settings.
- Colors can use hex codes (#RRGGBB) or color names (red, blue, etc.).