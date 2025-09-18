//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct READMECustomTagsSample: View {
    // Custom tags example from README
    @State private var htmlCode = """
        <h3>Custom Heading Tag</h3>
        <p>The h3 tag is implemented as a custom tag.</p>
        <ul>
            <li>First item</li>
            <li>Second item</li>
            <li>Third item</li>
        </ul>
        <video src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" />
        """
    
    @State private var renderingHTML = """
        <h3>Custom Heading Tag</h3>
        <p>The h3 tag is implemented as a custom tag.</p>
        <ul>
            <li>First item</li>
            <li>Second item</li>
            <li>Third item</li>
        </ul>
        <video src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" />
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("README Custom Tags")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Custom tags example from README - Editable")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Rendering Result
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rendering Result")
                        .font(.headline)
                    
                    HTMLView(html: renderingHTML, parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample) // configuration with custom tags registered
                        .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                // HTML Editor
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("HTML Editor")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button("Apply") {
                            renderingHTML = htmlCode
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    TextEditor(text: $htmlCode)
                        .font(.system(.body, design: .monospaced))
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .frame(minHeight: 140)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // Custom Tag Registration Code
                VStack(alignment: .leading, spacing: 8) {
                    Text("Custom Tag Registration (README Example)")
                        .font(.headline)
                    
                    Text("""
// README custom tag registration example
let configuration = HTMLConfiguration.default
    .register(tag: "video", renderer: VideoTag.self)
    .register(tag: "h3", renderer: HeadingLevel3.self)
    .register(tag: "ul", renderer: ULTagView.self)
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Actually Implemented Custom Tags
                VStack(alignment: .leading, spacing: 8) {
                    Text("Custom Tags Currently Implemented in Example")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• <h3>: Headinglevel3TagView - 18pt semibold")
                        Text("• <ul>: ULTagView - bullet point list")
                        Text("• <video>: VideoTagView - AVPlayer based")
                        Text("• <header>: HeaderTagView - gray background + border")
                    }
                    .font(.body)
                }
                
                // Custom Tag Examples to Try
                VStack(alignment: .leading, spacing: 8) {
                    Text("Custom Tag Examples to Try")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button("Header Structure") {
                            htmlCode = """
                                <header>
                                    <h1>Main Title</h1>
                                    <p>Header description text</p>
                                </header>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("리스트 구조") {
                            htmlCode = """
                                <h3>TODO 리스트</h3>
                                <ul>
                                    <li><strong>SwiftUIHTML</strong> 라이브러리 학습</li>
                                    <li><em>커스텀 태그</em> 만들어보기</li>
                                    <li>실제 프로젝트에 <u>적용</u>하기</li>
                                </ul>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("모든 커스텀 태그") {
                            htmlCode = """
                                <header>
                                    <h1>종합 예제</h1>
                                    <h3>커스텀 태그들</h3>
                                </header>
                                <ul>
                                    <li>헤더 태그</li>
                                    <li>H3 헤딩 태그</li>
                                    <li>리스트 태그</li>
                                </ul>
                                <video src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" />
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }
                }
                
                // 설명
                VStack(alignment: .leading, spacing: 8) {
                    Text("커스텀 태그에 대해")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Custom tag features introduced in README")
                        Text("• Direct implementation of tags not provided by default")
                        Text("• BlockTag: Block level custom UI")  
                        Text("• InlineTag: Inline text styling")
                        Text("• InlineAttachmentTag: Inline attachment elements")
                    }
                    .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("README Custom Tags")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        READMECustomTagsSample()
    }
}