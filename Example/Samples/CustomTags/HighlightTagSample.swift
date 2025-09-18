//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

// Highlight inline tag implementation
struct HighlightTag: InlineTag {
    static func applyStyles(
        with attributes: [String: AttributeValue],
        to styleContainer: inout HTMLStyleContainer
    ) {
        // Default yellow highlight
        styleContainer.backgroundColor = .yellow.opacity(0.3)
        
        // Apply color attribute if available
        if let colorValue = attributes["color"]?.string {
            if colorValue.hasPrefix("#") {
                styleContainer.foregroundColor = Color(hex: colorValue)
            }
        }
        
        // Support background-color attribute
        if let bgColorValue = attributes["background-color"]?.string {
            if bgColorValue.hasPrefix("#") {
                styleContainer.backgroundColor = Color(hex: bgColorValue).opacity(0.3)
            }
        }
    }
}

struct HighlightTagSample: View {
    // Custom Configuration (including highlight tag)
    private var highlightConfiguration: HTMLConfiguration {
        HTMLConfiguration.sample
            .register(tag: "highlight", renderer: HighlightTag.self)
            .register(tag: "mark", renderer: HighlightTag.self)
    }
    
    let html = """
        <h2>Highlight Tag Example</h2>
        
        <p>
            Regular text and <highlight>basic highlight</highlight> text can be 
            used together.
        </p>
        
        <p>
            The <mark>mark tag</mark> also provides the same highlight effect.
        </p>
        
        <p>
            Color specification is also possible: 
            <highlight color="#ff0000">red text</highlight> and 
            <highlight background-color="#00ff00">green background</highlight>
        </p>
        
        <p>
            Using <strong>bold</strong> and <highlight>highlight</highlight> together: 
            <strong><highlight>bold highlight</highlight></strong>
        </p>
        
        <p>
            Even in long text, <highlight>highlights are applied naturally</highlight> 
            and display <highlight>correctly across multiple lines</highlight>.
        </p>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Highlight Tag")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Inline highlight tag implementation")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // HTML Rendering
                HTMLView(html: html, parser: HTMLFuziParser())
                    .htmlEnvironment(\.configuration, highlightConfiguration)
                    .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // InlineTag Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("InlineTag Implementation")
                        .font(.headline)
                    
                    Text("InlineTag only changes text styles and does not generate actual views. It applies style properties to HTMLStyleContainer.")
                        .font(.body)
                }
                
                // Implementation Code
                VStack(alignment: .leading, spacing: 8) {
                    Text("HighlightTag Implementation")
                        .font(.headline)
                    
                    Text("""
struct HighlightTag: InlineTag {
    static func applyStyles(
        with attributes: [String: AttributeValue],
        to styleContainer: inout HTMLStyleContainer
    ) {
        // Default yellow highlight
        styleContainer.backgroundColor = .yellow.withAlphaComponent(0.3)
        
        // Handle color attributes
        if let colorValue = attributes["color"]?.string {
            styleContainer.foregroundColor = Color(hex: colorValue)
        }
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
    .register(tag: "highlight", renderer: HighlightTag.self)
    .register(tag: "mark", renderer: HighlightTag.self)
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // HTML Usage
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Usage")
                        .font(.headline)
                    
                    Text("""
<!-- Basic highlight -->
<highlight>highlight text</highlight>
<mark>mark tag</mark>

<!-- Color specification -->
<highlight color="#ff0000">red text</highlight>
<highlight background-color="#00ff00">green background</highlight>

<!-- Combination with other tags -->
<strong><highlight>bold highlight</highlight></strong>
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // InlineTag vs BlockTag
                VStack(alignment: .leading, spacing: 8) {
                    Text("InlineTag vs BlockTag")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("InlineTag")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("• Changes text style only")
                            Text("• Does not generate View")
                            Text("• Modifies HTMLStyleContainer")
                            Text("• Maintains inline flow")
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("BlockTag")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                            
                            Text("• Generates complete SwiftUI View")
                            Text("• Block-level element")
                            Text("• Independent layout")
                            Text("• Can compose complex UI")
                        }
                    }
                    .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("Highlight Tag")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Color extension for hex support
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    NavigationView {
        HighlightTagSample()
    }
}
