//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct LineHeightSample: View {
    let longText = """
        This is a long paragraph consisting of multiple lines.
        Adjusting line height significantly changes text readability.
        Proper line spacing creates easy-to-read text,
        but spacing that's too narrow or too wide actually harms readability.
        Through this example, you can see the differences between various line height settings.
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Line Height")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Line height and line spacing adjustment examples")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Narrow line height
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Line height 16pt (narrow)")
                            .font(.headline)
                        Spacer()
                        Text("14pt font")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HTMLView(html: "<p>\(longText)</p>", parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 14)
                            container.uiFont = font
                            container.textLine = .lineHeight(font: font, lineHeight: 16)
                            container.lineBreakMode = .byWordWrapping
                            return container
                        }())
                        .padding()
                        .background(Color(.systemRed).opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemRed), lineWidth: 1)
                        )
                }
                
                // Appropriate line height
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Line height 20pt (appropriate)")
                            .font(.headline)
                        Spacer()
                        Text("14pt font")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HTMLView(html: "<p>\(longText)</p>", parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 14)
                            container.uiFont = font
                            container.textLine = .lineHeight(font: font, lineHeight: 20)
                            container.lineBreakMode = .byWordWrapping
                            return container
                        }())
                        .padding()
                        .background(Color(.systemGreen).opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGreen), lineWidth: 1)
                        )
                }
                
                // Wide line height
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Line height 28pt (wide)")
                            .font(.headline)
                        Spacer()
                        Text("14pt font")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HTMLView(html: "<p>\(longText)</p>", parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 14)
                            container.uiFont = font
                            container.textLine = .lineHeight(font: font, lineHeight: 28)
                            container.lineBreakMode = .byWordWrapping
                            return container
                        }())
                        .padding()
                        .background(Color(.systemBlue).opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemBlue), lineWidth: 1)
                        )
                }
                
                // Line spacing usage
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Line spacing 8pt")
                            .font(.headline)
                        Spacer()
                        Text("14pt font")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HTMLView(html: "<p>\(longText)</p>", parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 14)
                            container.uiFont = font
                            container.textLine = .lineSpacing(spacing: 8)
                            container.lineBreakMode = .byWordWrapping
                            return container
                        }())
                        .padding()
                        .background(Color(.systemPurple).opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemPurple), lineWidth: 1)
                        )
                }
                
                // TextLine configuration method
                VStack(alignment: .leading, spacing: 8) {
                    Text("TextLine Configuration Method")
                        .font(.headline)
                    
                    Text("""
// Line height setting (absolute value)
let font = UIFont.systemFont(ofSize: 14)
container.textLine = .lineHeight(font: font, lineHeight: 20)

// Line spacing setting (relative value)
container.textLine = .lineSpacing(spacing: 8)
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Difference explanation
                VStack(alignment: .leading, spacing: 8) {
                    Text("Line Height vs Line Spacing")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Line Height (.lineHeight)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("• Specify total height of each line as absolute value")
                            Text("• Font size + top and bottom spacing")
                            Text("• Guarantees consistent line spacing")
                            Text("• Mainly used in design systems")
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Line Spacing (.lineSpacing)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.purple)
                            
                            Text("• Specify only additional spacing between lines")
                            Text("• Default line height + additional spacing")
                            Text("• Relative spacing adjustment")
                            Text("• Suitable for variable text sizes")
                        }
                    }
                    .font(.body)
                }
                
                // Readability tips
                VStack(alignment: .leading, spacing: 8) {
                    Text("Readability Improvement Tips")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Recommend 1.2-1.6x font size for line height")
                        Text("• Wider line spacing for longer text")
                        Text("• Maintain appropriate spacing on narrow screens")
                        Text("• Consistency matching brand tone and manner")
                    }
                    .font(.body)
                    .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Line Height")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LineHeightSample()
    }
}