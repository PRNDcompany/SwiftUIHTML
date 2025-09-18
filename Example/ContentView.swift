//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

// MARK: - Sample Category
enum SampleCategory: String, CaseIterable, Identifiable {
    case quickStart = "Quick Start"
    case basicUsage = "Basic Usage" 
    case styling = "Styling"
    case customTags = "Custom Tags"
    case parserIntegration = "Parser Integration"
    case testing = "Testing"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .quickStart: return "🚀"
        case .basicUsage: return "📖"
        case .styling: return "🎨"
        case .customTags: return "🔧"
        case .parserIntegration: return "🔌"
        case .testing: return "🧪"
        }
    }
    
    var samples: [SampleItem] {
        switch self {
        case .quickStart:
            return [
                SampleItem(title: "README Basic Usage", description: "Basic usage from README - Editable", view: READMEBasicUsageSample()),
                SampleItem(title: "README Custom Tags", description: "Custom tags from README - Editable", view: READMECustomTagsSample()),
                SampleItem(title: "README CSS Styling", description: "CSS styling from README - Editable", view: READMECSSStyling()),
                SampleItem(title: "Hello SwiftUIHTML", description: "Most basic example", view: HelloWorldSample()),
                SampleItem(title: "Rich Content", description: "Example with images and styles", view: RichContentSample())
            ]
        case .basicUsage:
            return [
                SampleItem(title: "Text Styling", description: "Bold, italic, underline", view: TextStyleSample()),
                SampleItem(title: "Image & Links", description: "Images and links example", view: ImageLinkSample()),
                SampleItem(title: "Block Elements", description: "Block element structure", view: BlockElementSample()),
                SampleItem(title: "Line Break Modes", description: "Line break mode comparison", view: LineBreakSample())
            ]
        case .styling:
            return [
                SampleItem(title: "CSS Colors", description: "Color styling", view: CSSColorSample()),
                SampleItem(title: "Box Model", description: "Padding, margin, border", view: BoxModelSample()),
                SampleItem(title: "Font Families", description: "Font family settings", view: FontFamilySample()),
                SampleItem(title: "Line Height", description: "Line height adjustment", view: LineHeightSample())
            ]
        case .customTags:
            return [
                SampleItem(title: "Custom Headings", description: "Custom h3 heading", view: CustomHeadingSample()),
                SampleItem(title: "List Tags", description: "ul, li tag implementation", view: CustomListSample()),
                SampleItem(title: "Video Tag", description: "Video playback tag", view: VideoTagSample()),
                SampleItem(title: "Highlight Tag", description: "Highlight inline tag", view: HighlightTagSample())
            ]
        case .parserIntegration:
            return [
                SampleItem(title: "Current Parser", description: "Currently used Fuzi parser", view: AnyView(CurrentParserSample())),
                SampleItem(title: "Complex HTML", description: "Complex HTML structure parsing", view: AnyView(ComplexHTMLSample()))
            ]
        case .testing:
            return [
                SampleItem(title: "Snapshot Test Preview", description: "Snapshot test preview - Image positioning and line height", view: SnapshotTestSample())
            ]
        }
    }
}

// MARK: - Sample Item
struct SampleItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let view: AnyView
    init<Content: View>(title: String, description: String, view: Content) {
        self.title = title
        self.description = description
        self.view = AnyView(view)
    }
}

// MARK: - Main Content View
struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("SwiftUIHTML")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Rendering HTML as native SwiftUI views")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Render HTML as native SwiftUI views")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 8)
                .listRowSeparator(.hidden)
                
                // Samples by category
                ForEach(SampleCategory.allCases) { category in
                    Section {
                        ForEach(category.samples) { sample in
                            NavigationLink(destination: sample.view) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(sample.title)
                                            .font(.headline)
                                        
                                        Text(sample.description)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                    } header: {
                        HStack {
                            Text(category.icon)
                            Text(category.rawValue)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            .navigationTitle("Examples")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
