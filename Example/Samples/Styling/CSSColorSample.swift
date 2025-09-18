//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct CSSColorSample: View {
    let html = """
        <h2>CSS Color Styles</h2>
        
        <p style="color: #FF5733;">Red text (#FF5733)</p>
        <p style="color: #2ECC71;">Green text (#2ECC71)</p>
        <p style="color: #3498DB;">Blue text (#3498DB)</p>
        <p style="color: #9B59B6;">Purple text (#9B59B6)</p>
        
        <h2>Background Color Styles</h2>
        
        <p style="background-color: #FFE5B4; padding: 8px;">Beige background</p>
        <p style="background-color: #E8F6F3; padding: 8px;">Mint background</p>
        <p style="background-color: #FADBD8; padding: 8px;">Light pink background</p>
        <p style="background-color: #D6EAF8; padding: 8px;">Light blue background</p>
        
        <h2>Color and Background Combinations</h2>
        
        <p style="color: white; background-color: #2C3E50; padding: 10px;">
            White text on dark background
        </p>
        
        <p style="color: #E74C3C; background-color: #FADBD8; padding: 10px;">
            Red text on pink background
        </p>
        
        <p style="color: #27AE60; background-color: #D5F4E6; padding: 10px;">
            Dark green text on light green background
        </p>
        
        <div style="background-color: #34495E; color: #ECF0F1; padding: 12px; border-radius: 8px;">
            <h3 style="color: #F1C40F; margin-top: 0;">Yellow title</h3>
            <p style="margin-bottom: 0;">
                This is a dark theme style box. 
                You can emphasize with <span style="color: #3498DB;">blue</span> and 
                <span style="color: #E74C3C;">red</span> colors.
            </p>
        </div>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("CSS Colors")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("CSS color properties usage example")
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
                
                // Supported Color Formats
                VStack(alignment: .leading, spacing: 8) {
                    Text("Supported Color Formats")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• HEX colors: #RRGGBB (e.g.: #FF5733)")
                        Text("• 3-digit HEX: #RGB (e.g.: #F53)")
                        Text("• Color names: red, blue, green, etc.")
                        Text("• RGB function: rgb(255, 87, 51)")
                    }
                    .font(.body)
                }
                
                // CSS Properties
                VStack(alignment: .leading, spacing: 8) {
                    Text("CSS Color Properties")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• color: text color")
                        Text("• background-color: background color")
                        Text("• inheritance: child elements inherit parent's color")
                        Text("• combination: use color and background-color together")
                    }
                    .font(.body)
                }
                
                // Usage Examples
                VStack(alignment: .leading, spacing: 8) {
                    Text("CSS Examples")
                        .font(.headline)
                    
                    Text("""
<!-- Text color -->
<p style="color: #FF5733;">Red text</p>

<!-- Background color -->
<p style="background-color: #FFE5B4;">Beige background</p>

<!-- Color combination -->
<p style="color: white; background-color: #2C3E50;">
    White text on dark background
</p>

<!-- Nested colors -->
<div style="background-color: #34495E; color: white;">
    Default white text and 
    <span style="color: #F1C40F;">yellow text</span>
</div>
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Color Tips
                VStack(alignment: .leading, spacing: 8) {
                    Text("Color Usage Tips")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Contrast: Sufficient contrast between text and background")
                        Text("• Consistency: Use brand colors consistently")
                        Text("• Accessibility: Consider colorblind users")
                        Text("• Hierarchy: Express information hierarchy with colors")
                    }
                    .font(.body)
                    .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("CSS Colors")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        CSSColorSample()
    }
}