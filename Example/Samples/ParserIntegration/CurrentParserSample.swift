//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct CurrentParserSample: View {
    let html = """
        <h2>Current Parser: HTMLFuziParser</h2>
        
        <p>This app uses the <strong>Fuzi</strong> library to parse HTML.</p>
        
        <div style="border: 1px solid #ccc; padding: 12px; background-color: #f9f9f9;">
            <h3>Features of Fuzi Parser:</h3>
            <p>
                • <strong>Fast Performance</strong>: libxml2 based<br>
                • <strong>Memory Efficient</strong>: Optimized parsing<br>
                • <strong>XML/HTML Support</strong>: Various format handling
            </p>
        </div>
        
        <p>Complex nested structures are also parsed accurately:</p>
        
        <div>
            <section>
                <p>Nested <em>elements are</em> <strong>correctly</strong> processed.</p>
            </section>
        </div>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Current Parser")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Currently using HTMLFuziParser")
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
                
                // Parser Information
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTMLFuziParser")
                        .font(.headline)
                    
                    Text("The default parser used in the Example project. Converts HTML to HTMLNode structure based on the Fuzi library.")
                        .font(.body)
                }
                
                // Parser Implementation (Partial)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Parser Implementation (Partial)")
                        .font(.headline)
                    
                    Text("""
struct HTMLFuziParser: HTMLParserable {
    func parse(html: String) -> HTMLNode {
        do {
            let document = try HTMLDocument(string: html, encoding: .utf8)
            guard let rootElement = document.root else {
                throw ParseError.noRootElement
            }
            return try elementToHTMLNode(element: rootElement)
        } catch {
            return HTMLNode(tag: "div", children: [.text("Parse error")])
        }
    }
}
""")
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Advantages
                VStack(alignment: .leading, spacing: 8) {
                    Text("Fuzi Parser Advantages")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Fast parsing performance")
                        Text("• Memory efficient")
                        Text("• Accurate HTML structure analysis")
                        Text("• libxml2-based stability")
                        Text("• Various HTML format support")
                    }
                    .font(.body)
                }
                
                // Comparison with other parsers
                VStack(alignment: .leading, spacing: 8) {
                    Text("Parser Selection Guide")
                        .font(.headline)
                    
                    Text("SwiftUIHTML can use any parser that implements the HTMLParserable protocol. You can choose Fuzi, SwiftSoup, or custom parsers.")
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Current Parser")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CurrentParserSample()
    }
}