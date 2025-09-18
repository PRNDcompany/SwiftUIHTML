//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct CustomListSample: View {
    let html = """
        <h2>Custom List Example</h2>
        
        <ul>
            <li>First item</li>
            <li>Second item</li>
            <li>Third item</li>
        </ul>
        
        <p>Middle text</p>
        
        <ul>
            <li>First item of another list</li>
            <li>Second item of another list</li>
            <li><strong>Emphasized</strong> item</li>
            <li>Item with link: <a href="https://example.com">example link</a></li>
        </ul>
        
        <div>
            <p>List inside nested div:</p>
            <ul>
                <li>Nested item 1</li>
                <li>Nested item 2</li>
            </ul>
        </div>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Custom List Tags")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Example of custom implementation of ul, li tags")
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
                
                // Implementation Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("UL Tag Custom Implementation")
                        .font(.headline)
                    
                    Text("The ul tag is not supported by default, but is implemented as a custom BlockTag.")
                        .font(.body)
                }
                
                // Implementation Code
                VStack(alignment: .leading, spacing: 8) {
                    Text("ULTagView Implementation")
                        .font(.headline)
                    
                    Text("""
struct ULTagView: BlockTag {
    let element: BlockElement
    
    init(element: BlockElement) {
        self.element = element
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(element.children.indices, id: \\.self) { index in
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
    .register(tag: "ul", renderer: ULTagView.self)
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // HTML Example
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Usage")
                        .font(.headline)
                    
                    Text("""
<ul>
    <li>First item</li>
                    <li>Second item</li>
    <li><strong>Emphasized</strong> item</li>
    <li>Link: <a href="...">link text</a></li>
</ul>
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Features
                VStack(alignment: .leading, spacing: 8) {
                    Text("Custom List Features")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Automatic bullet point (•) generation")
                        Text("• Renders li tag content")
                        Text("• Supports inline elements (strong, a, etc.)")
                        Text("• Proper indentation and spacing")
                        Text("• Vertical arrangement using VStack")
                    }
                    .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Custom List Tags")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CustomListSample()
    }
}