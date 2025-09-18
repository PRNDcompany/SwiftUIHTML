//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct ImageLinkSample: View {
    @State private var htmlCode = """
        <h2>Inline Images and Line Height Test</h2>
        
        <p>Small icons naturally fit between text <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> and larger <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> images align to line height.</p>
        
        <p>Various image sizes test: very small <img src="https://picsum.photos/id/100/8/8" width="8" height="8" /> 8px, 
        regular <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> 16px, 
        medium <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> 24px, 
        large <img src="https://picsum.photos/id/108/32/32" width="32" height="32" /> 32px images flow naturally with text.</p>
        
        <p>Long sentences with embedded images: Lorem ipsum dolor sit amet, <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> consectetur adipiscing elit. 
        Sed do eiusmod tempor incididunt ut labore <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> et dolore magna aliqua. 
        Ut enim ad minim veniam, quis nostrud <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> exercitation ullamco laboris 
        nisi ut aliquip ex ea commodo consequat.</p>
        
        <p>Mixed text with images: abcdefghijk <img src="https://picsum.photos/id/103/18/18" width="18" height="18" /> lmnopqrstuv 
        wxyzabcdefg <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> hijklmnopqr 
        stuvwxyzabc <img src="https://picsum.photos/id/105/22/22" width="22" height="22" /> defghijklmn.</p>
        
        <h3>Links and Images Combined</h3>
        <p>
            <a href="https://apple.com"><img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> Apple</a> makes iPhones,
            <a href="https://google.com"><img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> Google</a> provides search,
            <a href="https://github.com"><img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> GitHub</a> manages code.
        </p>
        """
    
    @State private var renderingHTML = """
        <h2>Inline Images and Line Height Test</h2>
        
        <p>Small icons naturally fit between text <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> and larger <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> images align to line height.</p>
        
        <p>Various image sizes test: very small <img src="https://picsum.photos/id/100/8/8" width="8" height="8" /> 8px, 
        regular <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> 16px, 
        medium <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> 24px, 
        large <img src="https://picsum.photos/id/108/32/32" width="32" height="32" /> 32px images flow naturally with text.</p>
        
        <p>Long sentences with embedded images: Lorem ipsum dolor sit amet, <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> consectetur adipiscing elit. 
        Sed do eiusmod tempor incididunt ut labore <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> et dolore magna aliqua. 
        Ut enim ad minim veniam, quis nostrud <img src="https://picsum.photos/id/106/24/24" width="24" height="24" /> exercitation ullamco laboris 
        nisi ut aliquip ex ea commodo consequat.</p>
        
        <p>Mixed text with images: abcdefghijk <img src="https://picsum.photos/id/103/18/18" width="18" height="18" /> lmnopqrstuv 
        wxyzabcdefg <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> hijklmnopqr 
        stuvwxyzabc <img src="https://picsum.photos/id/105/22/22" width="22" height="22" /> defghijklmn.</p>
        
        <h3>Links and Images Combined</h3>
        <p>
            <a href="https://apple.com"><img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> Apple</a> makes iPhones,
            <a href="https://google.com"><img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> Google</a> provides search,
            <a href="https://github.com"><img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> GitHub</a> manages code.
        </p>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Images & Links")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Inline image insertion and link creation example")
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
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 15)
                            container.uiFont = font
                            container.textLine = .lineHeight(font: font, lineHeight: 22)
                            container.lineBreakMode = .byWordWrapping
                            return container
                        }())
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
                        .frame(minHeight: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // Supported Features
                VStack(alignment: .leading, spacing: 8) {
                    Text("Supported Features")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• <img>: Inline image insertion")
                        Text("• width, height attributes for size control")
                        Text("• <a>: Clickable links")
                        Text("• href attribute: websites, emails, etc.")
                        Text("• Natural combination with text")
                    }
                    .font(.body)
                }
                
                // HTML Examples to Try
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Examples to Try")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button("Line Height Test") {
                            htmlCode = """
                                <p style="line-height: 24px;">Text with 24px line height contains <img src="https://picsum.photos/16/16?random=20" width="16" height="16" /> 16px image and <img src="https://picsum.photos/32/32?random=21" width="32" height="32" /> 32px image</p>
                                <p style="line-height: 18px;">Text with 18px line height contains <img src="https://picsum.photos/16/16?random=22" width="16" height="16" /> 16px image and <img src="https://picsum.photos/24/24?random=23" width="24" height="24" /> 24px image</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Complex Image Layout") {
                            htmlCode = """
                                <p>Consecutive images: <img src="https://picsum.photos/12/12?random=30" width="12" height="12" /><img src="https://picsum.photos/16/16?random=31" width="16" height="16" /><img src="https://picsum.photos/20/20?random=32" width="20" height="20" /><img src="https://picsum.photos/24/24?random=33" width="24" height="24" /> are placed next to each other.</p>
                                <p>Spaced images: <img src="https://picsum.photos/16/16?random=34" width="16" height="16" /> <img src="https://picsum.photos/20/20?random=35" width="20" height="20" /> <img src="https://picsum.photos/24/24?random=36" width="24" height="24" /> have spaces between them.</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Text and Image Integration") {
                            htmlCode = """
                                <p>Text sentences with <img src="https://picsum.photos/16/16?random=40" width="16" height="16" /> small icons and <img src="https://picsum.photos/24/24?random=41" width="24" height="24" /> large icons are naturally integrated. 
                                Like this <img src="https://picsum.photos/20/20?random=42" width="20" height="20" /> medium-sized icons are also included, 
                                and even in long sentences <img src="https://picsum.photos/18/18?random=43" width="18" height="18" /> they display naturally.</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Images & Links")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        ImageLinkSample()
    }
}