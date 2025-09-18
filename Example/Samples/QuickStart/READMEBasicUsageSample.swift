//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct READMEBasicUsageSample: View {
    // Exact example from README
    @State private var htmlCode = """
        <h1>Hello, SwiftUIHTML!</h1>
        <p>This is a <strong>paragraph</strong> with <em>styled</em> text.</p>
        <img src="https://picsum.photos/id/200/100/100" width="100" height="100" />
        """
    
    @State private var renderingHTML = """
        <h1>Hello, SwiftUIHTML!</h1>
        <p>This is a <strong>paragraph</strong> with <em>styled</em> text.</p>
        <img src="https://picsum.photos/id/200/100/100" width="100" height="100" />
        """
    
    private func createStyleContainer() -> HTMLStyleContainer {
        var container = HTMLStyleContainer()
        container.uiFont = .systemFont(ofSize: 16)
        container.lineBreakMode = .byWordWrapping
        return container
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("README Basic Usage")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Basic usage example from README - Editable")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Rendering Result
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rendering Result")
                        .font(.headline)
                    
                    HTMLView(html: renderingHTML, parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, createStyleContainer())
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                // HTML Edit Area
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Edit HTML")
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
                        .frame(minHeight: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // README Swift Code
                VStack(alignment: .leading, spacing: 8) {
                    Text("README Swift Code")
                        .font(.headline)
                    
                    Text("""
import SwiftUI
import SwiftUIHTML

struct ContentView: View {
    let html = \"\"\"
        <h1>Hello, SwiftUIHTML!</h1>
        <p>This is a <strong>paragraph</strong> with <em>styled</em> text.</p>
        <img src="https://example.com/image.jpg" width="100" height="100" />
        \"\"\"
    
    var body: some View {
        HTMLView(html: html, parser: HTMLFuziParser())
            .htmlEnvironment(\\.configuration, .default)
            .htmlEnvironment(\\.styleContainer, createStyleContainer())
    }
    
    func createStyleContainer() -> HTMLStyleContainer {
        var container = HTMLStyleContainer()
        container.uiFont = .systemFont(ofSize: 16)
        container.lineBreakMode = .byWordWrapping
        return container
    }
}
""")
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("About This Example")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Same example as basic usage in README.md")
                        Text("• Edit HTML directly and check results with 'Apply' button")
                        Text("• Basic usage of HTMLView + HTMLFuziParser")
                        Text("• Font and line break settings with HTMLStyleContainer")
                    }
                    .font(.body)
                }
                
                // HTML examples to try
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Examples to Try")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button("Simple text") {
                            htmlCode = "<h2>Hello!</h2><p>SwiftUIHTML test.</p>"
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Styled text") {
                            htmlCode = """
                                <h1 style="color: #2196F3;">Blue title</h1>
                                <p>Regular text and <strong style="color: #F44336;">red bold</strong></p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Include images") {
                            htmlCode = """
                                <h2>Image test</h2>
                                <p>Text with <img src="https://picsum.photos/50/50?random=2" width="50" height="50" /> image</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("README Basic Usage")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        READMEBasicUsageSample()
    }
}