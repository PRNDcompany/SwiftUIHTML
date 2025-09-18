//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct VideoTagSample: View {
    let html = """
        <h2>Video Tag Example</h2>
        
        <p>Below is a custom-implemented video tag:</p>
        
        <video src="https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4" />
        
        <p>The video has been displayed. Use valid video URLs in actual projects.</p>
        
        <p>It can also be used together with other text content.</p>
        """
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Video Tag")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Custom video tag using AVPlayer")
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
                
                // Video tag description
                VStack(alignment: .leading, spacing: 8) {
                    Text("Video Tag Implementation")
                        .font(.headline)
                    
                    Text("The video tag is not provided by default, but has been custom implemented using AVPlayer.")
                        .font(.body)
                }
                
                // Implementation code (partial)
                VStack(alignment: .leading, spacing: 8) {
                    Text("VideoTagView Implementation (Partial)")
                        .font(.headline)
                    
                    Text("""
struct VideoTagView: BlockTag, Equatable {
    let element: BlockElement
    let url: URL?
    @StateObject var context = Context()
    
    init(element: BlockElement) {
        self.element = element
        self.url = element.attributes["src"]?.url
    }
    
    var body: some View {
        if let player = context.player(url: url) {
            VideoPlayer(player: player)
                .aspectRatio(context.ratio, contentMode: .fit)
        }
    }
}
""")
                    .font(.system(.caption, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Registration method
                VStack(alignment: .leading, spacing: 8) {
                    Text("Register in Configuration")
                        .font(.headline)
                    
                    Text("""
let configuration = HTMLConfiguration.default
    .register(tag: "video", renderer: VideoTagView.self)
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // HTML usage
                VStack(alignment: .leading, spacing: 8) {
                    Text("HTML Usage")
                        .font(.headline)
                    
                    Text("""
<video src="https://example.com/video.mp4" />
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Features
                VStack(alignment: .leading, spacing: 8) {
                    Text("Video Tag Features")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• AVPlayer-based video playback")
                        Text("• Specify video URL with src attribute")
                        Text("• Automatic playback start")
                        Text("• Automatic aspect ratio adjustment")
                        Text("• VideoPlayer UI provided")
                        Text("• Implemented as block tag")
                    }
                    .font(.body)
                }
                
                // Considerations
                VStack(alignment: .leading, spacing: 8) {
                    Text("Important Considerations")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• Valid video URL required")
                        Text("• Check network connection status")
                        Text("• Consider video format compatibility")
                        Text("• App network permission settings")
                    }
                    .font(.body)
                    .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Video Tag")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        VideoTagSample()
    }
}