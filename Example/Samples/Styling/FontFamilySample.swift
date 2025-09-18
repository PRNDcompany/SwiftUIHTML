//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct FontFamilySample: View {
    let html = """
        <h2>Font Family Example</h2>
        
        <p>Text displayed with the default font.</p>
        
        <h3>System Fonts</h3>
        
        <p style="font-family: 'Helvetica';">
            Text using Helvetica font. It gives a clean and modern feel.
        </p>
        
        <p style="font-family: 'Arial';">
            Text using Arial font. One of the most widely used fonts on the web.
        </p>
        
        <p style="font-family: 'Times New Roman';">
            Text using Times New Roman font. A classic serif family font.
        </p>
        
        <p style="font-family: 'Georgia';">
            Text using Georgia font. A highly readable serif font.
        </p>
        
        <h3>Custom Font (Spoqa Han Sans)</h3>
        
        <p style="font-family: 'SpoqaHanSansNeo-Regular';">
            Korean text displayed with Spoqa Han Sans Regular. 
            A clean and modern Korean font.
        </p>
        
        <p style="font-family: 'SpoqaHanSansNeo-Bold';">
            Bold text displayed with Spoqa Han Sans Bold. 
            Suitable for titles or emphasis text.
        </p>
        
        <p style="font-family: 'SpoqaHanSansNeo-Light';">
            Light text displayed with Spoqa Han Sans Light. 
            Gives a delicate and refined feel.
        </p>
        
        <h3>Font Combinations</h3>
        
        <div style="background-color: #f5f5f5; padding: 16px; border-radius: 8px;">
            <h2 style="font-family: 'SpoqaHanSansNeo-Bold'; color: #333; margin-top: 0;">
                Bold Title
            </h2>
            <p style="font-family: 'SpoqaHanSansNeo-Regular'; color: #666; margin-bottom: 0;">
                Regular body text uses Regular font to improve readability. 
                <span style="font-family: 'SpoqaHanSansNeo-Bold'; color: #333;">Important parts can be Bold</span> for 
                emphasis.
            </p>
        </div>
        
        <div style="background-color: #e3f2fd; padding: 16px; border-radius: 8px; margin-top: 16px;">
            <p style="font-family: 'Helvetica'; color: #1976d2; margin: 0;">
                English text displayed with Helvetica font and 
                <span style="font-family: 'SpoqaHanSansNeo-Regular';">Korean displayed with Spoqa font</span> can 
                be used together.
            </p>
        </div>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Font Families")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Various font family usage examples")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // HTML rendering
                HTMLView(html: html, parser: HTMLFuziParser())
                    .htmlEnvironment(\.configuration, .sample)
                    .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                // Supported fonts
                VStack(alignment: .leading, spacing: 8) {
                    Text("Supported Font Types")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• System fonts: Helvetica, Arial, Times New Roman, etc.")
                        Text("• Custom fonts: Font files included in app")
                        Text("• Font stack: Multiple fonts specified in order")
                        Text("• Weight: Regular, Bold, Light, etc.")
                    }
                    .font(.body)
                }
                
                // CSS syntax
                VStack(alignment: .leading, spacing: 8) {
                    Text("font-family CSS Syntax")
                        .font(.headline)
                    
                    Text("""
/* Single font */
font-family: 'Helvetica';

/* Custom font */
font-family: 'SpoqaHanSansNeo-Regular';

/* Font stack (fallback) */
font-family: 'SpoqaHanSansNeo-Regular', 'Helvetica', sans-serif;

/* Font names with spaces require quotes */
font-family: 'Times New Roman';
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Custom font setup
                VStack(alignment: .leading, spacing: 8) {
                    Text("Using Custom Fonts")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("1. Add font files to project")
                        Text("2. Register fonts in Info.plist")
                        Text("3. Use correct PostScript names")
                        Text("4. Specify with font-family in HTML")
                    }
                    .font(.body)
                }
                
                // Info.plist example
                VStack(alignment: .leading, spacing: 8) {
                    Text("Info.plist Configuration")
                        .font(.headline)
                    
                    Text("""
<key>UIAppFonts</key>
<array>
    <string>SpoqaHanSansNeo-Regular.otf</string>
    <string>SpoqaHanSansNeo-Bold.otf</string>
    <string>SpoqaHanSansNeo-Light.otf</string>
</array>
""")
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Font selection guide
                VStack(alignment: .leading, spacing: 8) {
                    Text("Font Selection Guide")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Readability: Use readable fonts for body text")
                        Text("• Consistency: App-wide typography system")
                        Text("• Brand: Fonts that match brand identity")
                        Text("• File size: Consider font file sizes")
                        Text("• License: Check commercial usage rights")
                    }
                    .font(.body)
                    .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Font Families")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        FontFamilySample()
    }
}