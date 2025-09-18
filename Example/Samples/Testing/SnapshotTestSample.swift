//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI

@testable import SwiftUIHTML
@testable import SwiftUIHTMLExample

struct SnapshotTestSample: View {
    enum LineBreakModeOption: String, CaseIterable, Hashable {
        case byWordWrapping = "Word Wrapping"
        case byCharWrapping = "Char Wrapping"
        
        func toLineBreakMode() -> LineBreakMode {
            switch self {
            case .byWordWrapping:
                return .byWordWrapping
            case .byCharWrapping:
                return .byCharWrapping
            }
        }
    }
    
    @State private var htmlCode = """
        <h2>Snapshot Test HTML</h2>
        
        <p>Various sized inline image test:
        Between text <img src="https://picsum.photos/8/8?random=1" width="8" height="8" /> 8px image,
        <img src="https://picsum.photos/16/16?random=2" width="16" height="16" /> 16px image,
        <img src="https://picsum.photos/24/24?random=3" width="24" height="24" /> 24px image,
        <img src="https://picsum.photos/32/32?random=4" width="32" height="32" /> 32px image.</p>
        
        <p style="line-height: 24px;">Line height 24px test:
        <img src="https://picsum.photos/16/16?random=5" width="16" height="16" /> 16px image and
        <img src="https://picsum.photos/32/32?random=6" width="32" height="32" /> 32px image
        check how it affects line height.</p>
        
        <p>Consecutive images: <img src="https://picsum.photos/16/16?random=7" width="16" height="16" /><img src="https://picsum.photos/20/20?random=8" width="20" height="20" /><img src="https://picsum.photos/24/24?random=9" width="24" height="24" /> are placed like this.</p>
        
        <p>Long text with images: Lorem ipsum dolor sit amet <img src="https://picsum.photos/20/20?random=10" width="20" height="20" /> consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore <img src="https://picsum.photos/16/16?random=11" width="16" height="16" /> et dolore magna aliqua.</p>
        """
    
    @State private var renderingHTML = """
        <h2>Snapshot Test HTML</h2>
        
        <p>Various sized inline image test:
        Between text <img src="https://picsum.photos/8/8?random=1" width="8" height="8" /> 8px image,
        <img src="https://picsum.photos/16/16?random=2" width="16" height="16" /> 16px image,
        <img src="https://picsum.photos/24/24?random=3" width="24" height="24" /> 24px image,
        <img src="https://picsum.photos/32/32?random=4" width="32" height="32" /> 32px image.</p>
        
        <p style="line-height: 24px;">Line height 24px test:
        <img src="https://picsum.photos/16/16?random=5" width="16" height="16" /> 16px image and
        <img src="https://picsum.photos/32/32?random=6" width="32" height="32" /> 32px image
        check how it affects line height.</p>
        
        <p>Consecutive images: <img src="https://picsum.photos/16/16?random=7" width="16" height="16" /><img src="https://picsum.photos/20/20?random=8" width="20" height="20" /><img src="https://picsum.photos/24/24?random=9" width="24" height="24" /> are placed like this.</p>
        
        <p>Long text with images: Lorem ipsum dolor sit amet <img src="https://picsum.photos/20/20?random=10" width="20" height="20" /> consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore <img src="https://picsum.photos/16/16?random=11" width="16" height="16" /> et dolore magna aliqua.</p>
        """
    
    @State private var selectedLineBreakModeOption: LineBreakModeOption = .byWordWrapping
    @State private var frameWidth: CGFloat = 375
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Snapshot Test Sample")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Snapshot test example - Image positioning and line height testing")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Settings
                VStack(alignment: .leading, spacing: 12) {
                    Text("Test Settings")
                        .font(.headline)
                    
                    HStack {
                        Text("Line break mode:")
                        Picker("", selection: $selectedLineBreakModeOption) {
                            ForEach(LineBreakModeOption.allCases, id: \.self) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    
                    HStack {
                        Text("Width: \(Int(frameWidth))px")
                        Slider(value: $frameWidth, in: 200...400, step: 25)
                    }
                }
                
                // Rendering Result
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rendering Result")
                        .font(.headline)
                    
                    HTMLView(html: renderingHTML, parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 14)
                            container.uiFont = font
                            container.textLine = .lineHeight(font: font, lineHeight: 20)
                            container.lineBreakMode = selectedLineBreakModeOption.toLineBreakMode()
                            return container
                        }())
                        .frame(width: frameWidth)
                        .padding()
                        .background(Color(.systemGray6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
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
                        .frame(minHeight: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // Test cases
                VStack(alignment: .leading, spacing: 8) {
                    Text("Snapshot Test Cases")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button("testHTMLImageWithLineHeight") {
                            htmlCode = """
                                <p>
                                <span style="font-family: 'SpoqaHanSansNeo-Regular'"> textja <img src="https://picsum.photos/24/24?random=100" width="24" height="32" > </span>
                                <span style="font-family: 'SpoqaHanSansNeo-Regular'"> textja <img src="https://picsum.photos/24/24?random=101" width="24" height="24" > </span>
                                <span style="font-family: 'SpoqaHanSansNeo-Regular'"> textja12 <img src="https://picsum.photos/12/12?random=102" width="12" height="12" > </span>
                                </p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Inline Image Nesting Test") {
                            htmlCode = """
                                <h2>Inline Image Element</h2>
                                <p>This text contains an inline image: <img src="https://picsum.photos/50/50?random=200" width="8" height="8" alt="Small inline image"> 
                                This text contains an inline image: This text contains an inline image: This text contains an inline image: 
                                <img src="https://picsum.photos/50/50?random=201" width="4" height="4" alt="Small inline image"> 
                                This text contains an inline image: <img src="https://picsum.photos/50/50?random=202" width="50" height="50" alt="Small inline image"> 
                                and continues after it.</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Long word and image test") {
                            htmlCode = """
                                <p>This is a very long Korean word and verylongEnglishwordthatwillnotfitinasingleline containing text.
                                <img src="https://picsum.photos/20/20?random=300" width="20" height="20" />
                                In the middle there is an image and continuing text pneumonoultramicroscopicsilicovolcanoconiosis.
                                <img src="https://picsum.photos/16/16?random=301" width="16" height="16" />
                                This is the last image.</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Complex image layout") {
                            htmlCode = """
                                <section>
                                    <h2>Complex image layout</h2>
                                    <p>First line: <img src="https://picsum.photos/16/16?random=400" width="16" height="16" /> small image</p>
                                    <p>Second line: <img src="https://picsum.photos/24/24?random=401" width="24" height="24" /> medium image</p>
                                    <p>Third line: <img src="https://picsum.photos/32/32?random=402" width="32" height="32" /> large image</p>
                                    <p>Consecutive images: <img src="https://picsum.photos/20/20?random=403" width="20" height="20" /><img src="https://picsum.photos/20/20?random=404" width="20" height="20" /><img src="https://picsum.photos/20/20?random=405" width="20" height="20" /></p>
                                    <p>Text <img src="https://picsum.photos/16/16?random=406" width="16" height="16" /> between <img src="https://picsum.photos/24/24?random=407" width="24" height="24" /> image <img src="https://picsum.photos/20/20?random=408" width="20" height="20" /> placement</p>
                                </section>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }
                }
                
                // Test information
                VStack(alignment: .leading, spacing: 8) {
                    Text("Snapshot Test Information")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Test file: SwiftUIHTMLExampleTests/HTMLBasicTests.swift")
                        Text("• Run tests: Cmd+U or Product > Test")
                        Text("• Focuses on testing image positioning and line height")
                        Text("• Check how various sized images align with text")
                        Text("• Compare differences based on line break modes")
                    }
                    .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Snapshot Test")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        SnapshotTestSample()
    }
}
