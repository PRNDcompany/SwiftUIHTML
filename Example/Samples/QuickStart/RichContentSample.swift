//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct RichContentSample: View {
    let html = """
        <header style="background-color: #f0f8ff; padding: 16px; border-radius: 8px;">
            <h1 style="color: #1e3a8a;">SwiftUIHTML Demo</h1>
            <p style="color: #64748b;">Showcasing various HTML elements in one view</p>
        </header>
        
        <main style="margin-top: 16px;">
            <section style="margin-bottom: 20px;">
                <h2>Text Styles</h2>
                <p>
                    <strong>Bold text</strong>, <em>Italic text</em>, 
                    <span style="color: #ef4444;">Red color</span>, 
                    <span style="background-color: #fef3c7;">Highlighted</span>
                </p>
            </section>
            
            <section style="margin-bottom: 20px;">
                <h2>Images</h2>
                <p>
                    Inline image example: 
                    <img src="https://picsum.photos/id/200/40/40" width="20" height="20" />
                    displayed with text flow.
                </p>
            </section>
            
            <section style="border: 1px solid #e5e7eb; padding: 12px; border-radius: 6px;">
                <h2 style="margin-top: 0;">Links</h2>
                <p>
                    External link: <a href="https://github.com">GitHub</a><br>
                    Email: <a href="mailto:test@example.com">test@example.com</a>
                </p>
            </section>
        </main>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rich Content")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Rich content with images, styles, and links")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // HTML Rendering
                HTMLView(html: html, parser: HTMLFuziParser())
                    .htmlEnvironment(\.configuration, .sample)
                    .htmlEnvironment(\.styleContainer, {
                        var container = HTMLStyleContainer()
                        let font = UIFont.systemFont(ofSize: 15)
                        container.uiFont = font
                        container.textLine = .lineHeight(font: font, lineHeight: 22)
                        container.lineBreakMode = .byWordWrapping
                        return container
                    }())
                    .padding()
                    .background(Color(.systemBackground))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    )
                
                // Features
                VStack(alignment: .leading, spacing: 8) {
                    Text("Included Features")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• CSS inline styles (colors, background, padding)")
                        Text("• Inline images")
                        Text("• Links (websites, email)")
                        Text("• Block element structure (header, main, section)")
                        Text("• Text styles (bold, italic)")
                    }
                    .font(.body)
                }
                
                // HTML Code Sample
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Example (Snippet)")
                        .font(.headline)
                    
                    Text("""
<header style="background-color: #f0f8ff; padding: 16px;">
    <h1 style="color: #1e3a8a;">SwiftUIHTML Demo</h1>
    <p style="color: #64748b;">Various HTML elements...</p>
</header>

<main>
    <section>
        <h2>Text Styles</h2>
        <p>
            <strong>Bold</strong>, <em>Italic</em>, 
            <span style="color: #ef4444;">Red</span>
        </p>
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
        .navigationTitle("Rich Content")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        RichContentSample()
    }
}
