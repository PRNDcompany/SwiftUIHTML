//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct LineBreakSample: View {
    @State private var htmlCode = """
        <h2>Line Break and Image Test</h2>
        
        <p>Long word and image test: ThisIsAVeryLongKoreanWordAndverylongEnglishwordthatwillnotfitinasinglelineIncluded.
        And <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> images are also included in the middle.</p>
        
        <p>Korean-English mixed: GeneralKoreanTextAndEnglish text를섞어서사용할때 
        <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> when images are included 
        you can compare the line breaking behavior.</p>
        
        <p>Consecutive images with text: 
        <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /><img src="https://picsum.photos/id/103/18/18" width="18" height="18" /><img src="https://picsum.photos/id/104/20/20" width="20" height="20" />
        see how line breaks work when there are consecutive images and long text together like this.</p>
        """
    
    @State private var renderingHTML = """
        <h2>Line Break and Image Test</h2>
        
        <p>Long word and image test: ThisIsAVeryLongKoreanWordAndverylongEnglishwordthatwillnotfitinasinglelineIncluded.
        And <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /> images are also included in the middle.</p>
        
        <p>Korean-English mixed: GeneralKoreanTextAndEnglish text를섞어서사용할때 
        <img src="https://picsum.photos/id/104/20/20" width="20" height="20" /> when images are included 
        you can compare the line breaking behavior.</p>
        
        <p>Consecutive images with text: 
        <img src="https://picsum.photos/id/102/16/16" width="16" height="16" /><img src="https://picsum.photos/id/103/18/18" width="18" height="18" /><img src="https://picsum.photos/id/104/20/20" width="20" height="20" />
        see how line breaks work when there are consecutive images and long text together like this.</p>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Line Break Modes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Line break mode comparison: word-based vs character-based")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Word-based line breaking
                VStack(alignment: .leading, spacing: 8) {
                    Text("Word-based line breaking (.byWordWrapping)")
                        .font(.headline)
                    
                    HTMLView(html: renderingHTML, parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 14)
                            container.uiFont = font
                            container.textLine = .lineHeight(font: font, lineHeight: 20)
                            container.lineBreakMode = .byWordWrapping
                            return container
                        }())
                        .frame(width: 280)
                        .padding()
                        .background(Color(.systemBlue).opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemBlue), lineWidth: 1)
                        )
                }
                
                // Character-based line breaking
                VStack(alignment: .leading, spacing: 8) {
                    Text("Character-based line breaking (.byCharWrapping)")
                        .font(.headline)
                    
                    HTMLView(html: renderingHTML, parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, {
                            var container = HTMLStyleContainer()
                            let font = UIFont.systemFont(ofSize: 14)
                            container.uiFont = font
                            container.textLine = .lineHeight(font: font, lineHeight: 20)
                            container.lineBreakMode = .byCharWrapping
                            return container
                        }())
                        .frame(width: 280)
                        .padding()
                        .background(Color(.systemGreen).opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGreen), lineWidth: 1)
                        )
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
                
                // Difference explanation
                VStack(alignment: .leading, spacing: 8) {
                    Text("Line Break Mode Differences")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Word-based (.byWordWrapping)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            
                            Text("• Line breaks only at spaces")
                            Text("• Long words are not truncated")
                            Text("• Suitable for English text")
                            Text("• Maintains word integrity")
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Character-based (.byCharWrapping)")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.green)
                            
                            Text("• Line breaks possible at any character")
                            Text("• Long words are automatically split")
                            Text("• Suitable for Korean, Chinese, Japanese")
                            Text("• Full utilization of container width")
                        }
                    }
                    .font(.body)
                }
                
                // HTML Examples to Try
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Examples to Try")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button("Text with Many Images") {
                            htmlCode = """
                                <p>Travel itinerary: Tomorrow <img src="https://picsum.photos/16/16?random=10" width="16" height="16" /> take a plane and 
                                <img src="https://picsum.photos/20/20?random=11" width="20" height="20" /> go to Paris to 
                                <img src="https://picsum.photos/18/18?random=12" width="18" height="18" /> see the Eiffel Tower and 
                                <img src="https://picsum.photos/16/16?random=13" width="16" height="16" /> visit the Louvre Museum.</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Long Words and Images") {
                            htmlCode = """
                                <p>Supercalifragilisticexpialidocious<img src="https://picsum.photos/20/20?random=20" width="20" height="20" />
                                andpneumonoultramicroscopicsilicovolcanoconiosis<img src="https://picsum.photos/16/16?random=21" width="16" height="16" />
                                suchverylongwords<img src="https://picsum.photos/18/18?random=22" width="18" height="18" />areincludedinthistext</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Various Size Image Test") {
                            htmlCode = """
                                <p style="line-height: 24px;">Line height 24px: 
                                text <img src="https://picsum.photos/8/8?random=30" width="8" height="8" /> 8px 
                                <img src="https://picsum.photos/16/16?random=31" width="16" height="16" /> 16px 
                                <img src="https://picsum.photos/24/24?random=32" width="24" height="24" /> 24px 
                                <img src="https://picsum.photos/32/32?random=33" width="32" height="32" /> 32px images</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Line Break Modes")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        LineBreakSample()
    }
}