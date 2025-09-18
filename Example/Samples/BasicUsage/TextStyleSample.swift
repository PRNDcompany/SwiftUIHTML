//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct TextStyleSample: View {
    @State private var htmlCode = """
        <h2>Text Styling Example</h2>
        
        <p>This is basic text content.</p>
        
        <p><strong>Bold text</strong> and <b>b tag</b> can be used together.</p>
        
        <p><em>Italic text</em> and <i>i tag</i> are also supported.</p>
        
        <p><u>Underlined text</u> is possible too.</p>
        
        <p>
            <strong>Combinations are available:</strong> 
            <em><strong>Bold Italic</strong></em>, 
            <u><strong>Bold Underline</strong></u>
        </p>
        
        <p>
            Even in long text, <strong>bold</strong> and <em>italic</em> 
            styles are <u>applied</u> naturally. <strong>Styles are maintained</strong> 
            across multiple lines as well.
        </p>
        """
    
    @State private var renderingHTML = """
        <h2>Text Styling Example</h2>
        
        <p>This is basic text content.</p>
        
        <p><strong>Bold text</strong> and <b>b tag</b> can be used together.</p>
        
        <p><em>Italic text</em> and <i>i tag</i> are also supported.</p>
        
        <p><u>Underlined text</u> is possible too.</p>
        
        <p>
            <strong>Combinations are available:</strong> 
            <em><strong>Bold Italic</strong></em>, 
            <u><strong>Bold Underline</strong></u>
        </p>
        
        <p>
            Even in long text, <strong>bold</strong> and <em>italic</em> 
            styles are <u>applied</u> naturally. <strong>Styles are maintained</strong> 
            across multiple lines as well.
        </p>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Text Styling")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Bold, italic, and underline text styling")
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
                        .htmlEnvironment(\.styleContainer, .sample(by: .byWordWrapping))
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                // HTML Editor
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("HTML Editor")
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
                        .frame(minHeight: 150)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // Supported Tags
                VStack(alignment: .leading, spacing: 8) {
                    Text("Supported Tags")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• <strong> or <b>: Bold text")
                        Text("• <em> or <i>: Italic text")
                        Text("• <u>: Underlined text")
                        Text("• Tag combinations supported")
                    }
                    .font(.body)
                }
                
                // HTML Examples to Try
                VStack(alignment: .leading, spacing: 8) {
                    Text("Try These HTML Examples")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button("Simple Text Styles") {
                            htmlCode = "<p>Regular text with <strong>bold</strong>, <em>italic</em>, <u>underline</u></p>"
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Complex Style Combinations") {
                            htmlCode = """
                                <h3>Style Combination Example</h3>
                                <p>
                                    <strong><em>Bold Italic</em></strong>, 
                                    <u><strong>Underline Bold</strong></u>, 
                                    <em><u>Italic Underline</u></em>
                                </p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Long Text Styling") {
                            htmlCode = """
                                <p>
                                    Lorem ipsum dolor sit amet, <strong>consectetur adipiscing elit</strong>. 
                                    Sed do eiusmod tempor incididunt ut <em>labore et dolore magna</em> aliqua. 
                                    Ut enim ad minim veniam, <u>quis nostrud exercitation</u> ullamco laboris.
                                </p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Text Styling")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        TextStyleSample()
    }
}