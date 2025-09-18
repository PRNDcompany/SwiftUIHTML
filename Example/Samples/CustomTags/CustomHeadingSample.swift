//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct CustomHeadingSample: View {
    let html = """
        <h1>This is an H1 heading</h1>
        <p>h1 is implemented with a custom renderer.</p>
        
        <h2>This is an H2 heading</h2>
        <p>h2 also has styles applied with a custom renderer.</p>
        
        <h3>This is an H3 heading</h3>
        <p>h3 is not provided by default but is implemented as a custom tag.</p>
        
        <div>
            <h1>Even in nested structures</h1>
            <h2>headings render</h2>
            <h3>normally</h3>
        </div>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Custom Headings")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Custom implemented heading tags")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // HTML Rendering
                HTMLView(html: html, parser: HTMLFuziParser())
                    .htmlEnvironment(\.configuration, .sample)
                    .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Custom Tag Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Custom Heading Implementation")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• h1, h2: Default provided + custom renderer")
                        Text("• h3: Fully implemented as custom")
                        Text("• Each has different font size and style")
                        Text("• Registered in HTMLConfiguration")
                    }
                    .font(.body)
                }
                
                // Implementation Code Example
                VStack(alignment: .leading, spacing: 8) {
                    Text("H3 Custom Tag Implementation")
                        .font(.headline)
                    
                    Text("""
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
""")
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Registration Method
                VStack(alignment: .leading, spacing: 8) {
                    Text("Register to Configuration")
                        .font(.headline)
                    
                    Text("""
let configuration = HTMLConfiguration.default
    .register(tag: "h1", renderer: Headinglevel1TagView.self)
    .register(tag: "h2", renderer: Headinglevel2TagView.self)
    .register(tag: "h3", renderer: Headinglevel3TagView.self)
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Features
                VStack(alignment: .leading, spacing: 8) {
                    Text("Advantages of Custom Headings")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Apply styles that match app's design system")
                        Text("• Consistent typography system")
                        Text("• Improved accessibility (semantic structure)")
                        Text("• Reflects brand identity")
                    }
                    .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Custom Headings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CustomHeadingSample()
    }
}