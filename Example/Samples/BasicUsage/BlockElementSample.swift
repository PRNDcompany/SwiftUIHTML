//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct BlockElementSample: View {
    let html = """
        <header>
            <h1>Header Area</h1>
            <p>This is content inside the header tag.</p>
        </header>
        
        <main>
            <section>
                <h2>First Section</h2>
                <div>
                    <p>First paragraph inside div.</p>
                    <p>Second paragraph inside div.</p>
                </div>
            </section>
            
            <section>
                <h2>Second Section</h2>
                <div>
                    <div>
                        <p>This is a nested div structure.</p>
                        <p>Deep HTML structures can be handled as well.</p>
                    </div>
                </div>
            </section>
        </main>
        
        <footer>
            <p>Footer content goes here.</p>
        </footer>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Block Elements")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Block element structure and nesting")
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
                
                // Supported Block Tags
                VStack(alignment: .leading, spacing: 8) {
                    Text("Supported Block Tags")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• <div>: Generic container")
                        Text("• <p>: Paragraph")
                        Text("• <header>: Header section")
                        Text("• <main>: Main content")
                        Text("• <section>: Section division")
                        Text("• <footer>: Footer section")
                        Text("• <h1>, <h2>: Headings")
                    }
                    .font(.body)
                }
                
                // HTML Structure
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Structure")
                        .font(.headline)
                    
                    Text("""
<header>
    <h1>Header Section</h1>
    <p>Header content</p>
</header>

<main>
    <section>
        <h2>Section Title</h2>
        <div>
            <p>Nested content</p>
        </div>
    </section>
</main>

<footer>
    <p>Footer content</p>
</footer>
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Features
                VStack(alignment: .leading, spacing: 8) {
                    Text("Features")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Block elements stack vertically")
                        Text("• Nested structure support")
                        Text("• Semantic HTML tag usage")
                        Text("• Styles can be applied to all block tags")
                    }
                    .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Block Elements")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        BlockElementSample()
    }
}