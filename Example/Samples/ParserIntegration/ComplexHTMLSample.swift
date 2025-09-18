//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct ComplexHTMLSample: View {
    let html = """
        <header style="background-color: #e3f2fd; padding: 16px; border-radius: 8px; margin-bottom: 16px;">
            <h1 style="color: #1565c0; margin: 0;">Complex HTML Structure Test</h1>
            <p style="color: #424242; margin: 8px 0 0 0;">Example with nested elements and various styles</p>
        </header>
        
        <main>
            <section style="margin-bottom: 20px;">
                <h2>First Section</h2>
                <div style="border: 1px solid #ddd; padding: 12px; border-radius: 6px;">
                    <p>
                        This paragraph includes <strong>bold</strong> and <em>italic</em>, 
                        <span style="color: #f44336;">red text</span>, 
                        and a <a href="https://example.com">link</a>.
                    </p>
                    
                    <div style="background-color: #fff3e0; padding: 8px; margin-top: 8px;">
                        <p style="margin: 0;">
                            Content inside nested div. 
                            <img src="https://picsum.photos/24/24?random=1" width="24" height="24" />
                            Images are also included.
                        </p>
                    </div>
                </div>
            </section>
            
            <section style="background-color: #f5f5f5; padding: 16px; border-radius: 8px;">
                <h2 style="color: #333; margin-top: 0;">Second Section</h2>
                
                <div style="display: flex; gap: 16px;">
                    <div style="flex: 1; background-color: white; padding: 12px; border-radius: 4px;">
                        <h3>Card 1</h3>
                        <p>
                            Content of the first card. 
                            Contains <strong>important</strong> information.
                        </p>
                    </div>
                    
                    <div style="flex: 1; background-color: white; padding: 12px; border-radius: 4px;">
                        <h3>Card 2</h3>
                        <p>
                            Content of the second card. 
                            Has content <em>to emphasize</em>.
                        </p>
                    </div>
                </div>
                
                <div style="margin-top: 16px; padding: 12px; background-color: #e8f5e8; border-radius: 4px;">
                    <p style="margin: 0;">
                        <strong>Notice:</strong> This area is a notification box 
                        with special styling applied. Various <u>text styles</u> 
                        and <span style="background-color: #ffeb3b;">highlights</span> 
                        can be used together.
                    </p>
                </div>
            </section>
        </main>
        
        <footer style="margin-top: 24px; padding: 16px; background-color: #263238; color: white; border-radius: 8px;">
            <h3 style="color: white; margin-top: 0;">Footer Area</h3>
            <p style="margin-bottom: 0;">
                This example shows how SwiftUIHTML can accurately 
                parse and render even complex HTML structures. 
                <strong style="color: #81c784;">Nested elements</strong> and 
                <em style="color: #64b5f6;">various styles</em> 
                are all displayed correctly.
            </p>
        </footer>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Complex HTML")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("복잡한 HTML 구조 파싱 테스트")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // HTML 렌더링
                HTMLView(html: html, parser: HTMLFuziParser())
                    .htmlEnvironment(\.configuration, .sample)
                    .htmlEnvironment(\.styleContainer, {
                        var container = HTMLStyleContainer()
                        let font = UIFont.systemFont(ofSize: 14)
                        container.uiFont = font
                        container.textLine = .lineHeight(font: font, lineHeight: 20)
                        container.lineBreakMode = .byWordWrapping
                        return container
                    }())
                    .padding()
                    .background(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                
                // 복잡성 설명
                VStack(alignment: .leading, spacing: 8) {
                    Text("이 예제에 포함된 복잡성")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• 다층 중첩 구조 (header > main > section > div > p)")
                        Text("• 다양한 CSS 스타일 속성")
                        Text("• 인라인 요소와 블록 요소의 조합")
                        Text("• 이미지와 링크가 포함된 텍스트")
                        Text("• 색상, 배경, 패딩, 마진, 테두리")
                        Text("• 시맨틱 HTML 태그 활용")
                    }
                    .font(.body)
                }
                
                // 파싱 과정
                VStack(alignment: .leading, spacing: 8) {
                    Text("파싱 과정")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("1. HTML 문자열을 Fuzi로 파싱")
                        Text("2. DOM 트리를 HTMLNode 구조로 변환")
                        Text("3. 각 요소의 속성과 스타일 추출")
                        Text("4. SwiftUI View 계층으로 렌더링")
                        Text("5. CSS 스타일을 SwiftUI 모디파이어로 변환")
                    }
                    .font(.body)
                }
                
                // 성능 정보
                VStack(alignment: .leading, spacing: 8) {
                    Text("성능 특징")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• 실시간 파싱 및 렌더링")
                        Text("• 메모리 효율적인 구조")
                        Text("• SwiftUI의 네이티브 성능")
                        Text("• 부분 업데이트 지원")
                        Text("• 스크롤 성능 최적화")
                    }
                    .font(.body)
                }
                
                // HTML 구조 (일부)
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML 구조 예제 (일부)")
                        .font(.headline)
                    
                    Text("""
<header style="background-color: #e3f2fd; padding: 16px;">
    <h1 style="color: #1565c0;">제목</h1>
    <p style="color: #424242;">설명</p>
</header>

<main>
    <section>
        <div style="border: 1px solid #ddd;">
            <p>
                <strong>볼드</strong>와 <em>이탤릭</em>, 
                <span style="color: #f44336;">색상</span>
            </p>
        </div>
    </section>
</main>
""")
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Complex HTML")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ComplexHTMLSample()
    }
}