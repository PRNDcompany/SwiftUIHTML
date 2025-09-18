//  Copyright © 2025 PRND. All rights reserved.

import SwiftUI
import SwiftUIHTML

struct READMECSSStyling: View {
    enum LineBreakType {
        case byWordWrapping
        case byCharWrapping
        
        var html: LineBreakMode {
            switch self {
            case .byWordWrapping: return .byWordWrapping
            case .byCharWrapping: return .byCharWrapping
            }
        }
    }
    // CSS styling example from README (long text to see line break effects)
    @State private var htmlCode = """
        <div style="padding: 20px; background-color: #f0f0f0; border-radius: 8px;">
            <h2 style="color: #333;">Style Example</h2>
            <p style="font-family: 'Helvetica'; color: #666;">
                Text with CSS inline styles applied. Thiscontainslongkoreanwordverylongwordthatwillnotfitonasinglelinetotest to see line break mode differences.
            </p>
            <p style="color: #2196F3; background-color: #E3F2FD; padding: 10px; border-radius: 4px;">
                Word wrapping vs character wrapping differences: suchlongtexttogetherwithlongkoreanwordswithsuperlongEnglishwordswithoutspaces for testing.
            </p>
        </div>
        """
    
    @State private var renderingHTML = """
        <div style="padding: 20px; background-color: #f0f0f0; border-radius: 8px;">
            <h2 style="color: #333;">Style Example</h2>
            <p style="font-family: 'Helvetica'; color: #666;">
                Text with CSS inline styles applied. Thiscontainslongkoreanwordverylongwordthatwillnotfitonasinglelinetotest to see line break mode differences.
            </p>
            <p style="color: #2196F3; background-color: #E3F2FD; padding: 10px; border-radius: 4px;">
                Word wrapping vs character wrapping differences: suchlongtexttogetherwithlongkoreanwordswithsuperlongEnglishwordswithoutspaces for testing.
            </p>
        </div>
        """
    
    // Line break mode settings
    @State private var lineBreakMode: LineBreakType = .byWordWrapping
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title
                VStack(alignment: .leading, spacing: 8) {
                    Text("README CSS Styling")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("README CSS Styling Examples - Editable")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Rendering Result
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text("Rendering Result")
                            .font(.headline)
                        
                        Spacer()
                        
                        // Line break mode selection
                        Picker("Line Break", selection: $lineBreakMode) {
                            Text("Word").tag(LineBreakType.byWordWrapping)
                            Text("Character").tag(LineBreakType.byCharWrapping)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 120)
                    }
                    
                    HTMLView(html: renderingHTML, parser: HTMLFuziParser())
                        .htmlEnvironment(\.configuration, .sample)
                        .htmlEnvironment(\.styleContainer, .sample(by: lineBreakMode.html))
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
                        .frame(minHeight: 140)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                }
                
                // README Line Break Mode Setup Code
                VStack(alignment: .leading, spacing: 8) {
                    Text("README Line Break Mode Setup")
                        .font(.headline)
                    
                    Text("""
// README line break mode setup example
var container = HTMLStyleContainer()
container.lineBreakMode = .byWordWrapping  // or .byCharWrapping

HTMLView(html: html, parser: parser)
    .htmlEnvironment(\\.styleContainer, container)
""")
                    .font(.system(.body, design: .monospaced))
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                
                // Supported CSS Properties
                VStack(alignment: .leading, spacing: 8) {
                    Text("Supported CSS Properties")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("All elements:")
                            .fontWeight(.semibold)
                        Text("• color: Text color (#RRGGBB)")
                        Text("• background-color: Background color")
                        Text("• font-family: Font family")
                        Text("• border-radius: Corner radius")
                        
                        Text("Block elements only (div, p, etc.):")
                            .fontWeight(.semibold)
                            .padding(.top, 8)
                        Text("• padding: Inner spacing (20px or 10px 20px)")
                        Text("• margin: Outer spacing")
                        Text("• border: Border (1px solid #333)")
                        
                        Text("⚠️ inline elements (span, strong) don't support padding/margin")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .padding(.top, 4)
                    }
                    .font(.body)
                }
                
                // CSS Examples to Try
                VStack(alignment: .leading, spacing: 8) {
                    Text("CSS Examples to Try")
                        .font(.headline)
                    
                    VStack(spacing: 8) {
                        Button("Line Break Test") {
                            htmlCode = """
                                <p>ThisisalinebreaktestwithverylongkoreanwordandverylongEnglishwordwithoutanyspacesinthetextforlinebreaktesting.</p>
                                <p style="background-color: #FFF3E0; padding: 8px;">Comparelongwordswithoutspacesbetweenwordswithsupercalifragilisticexpialidocioussuchlongenglishwordlinebreakbehavior.</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Card Style") {
                            htmlCode = """
                                <div style="background-color: white; border: 1px solid #e0e0e0; border-radius: 8px; padding: 16px;">
                                    <h3 style="color: #333; margin-top: 0;">Cardtitleisverylongandneedslinebreaksinlongsentences</h3>
                                    <p style="color: #666; margin-bottom: 0;">Cardcontentisalsolongandyoucanseelnebreakmodedifferencesbetweenmodes. verylongcontentwithoutseparationbetweenwords</p>
                                </div>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("Various Fonts + Line Break") {
                            htmlCode = """
                                <p style="font-family: 'Helvetica';">Helveticafontdisplaysverylongtextwithoutspaceswith verylongwordswithoutspaces</p>
                                <p style="font-family: 'SpoqaHanSansNeo-Regular';">SpoqaRegularfontlongsentenceswith anothersuperlongwordwithoutanybreaks</p>
                                <p style="font-family: 'SpoqaHanSansNeo-Bold';">스포카Bold폰트의줄바꿈테스트용텍스트antidisestablishmentarianism</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                        
                        Button("URL 테스트") {
                            htmlCode = """
                                <p>긴URL의줄바꿈: https://www.verylongdomainname.com/very/long/path/to/resource?with=parameters&and=more&parameters=here</p>
                                <p>이메일: verylongemailaddress@extremelylongdomainname.com</p>
                                """
                        }
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.bordered)
                    }
                }
                
                // 설명
                VStack(alignment: .leading, spacing: 8) {
                    Text("CSS 스타일링에 대해")
                        .font(.headline)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("• README에서 소개하는 CSS 스타일 기능")
                        Text("• HTML 요소에 직접 style 속성 적용")
                        Text("• SwiftUI 모디파이어로 자동 변환")
                        Text("• 줄바꿈 모드는 HTMLStyleContainer에서 설정")
                        Text("• Brand colors and design system utilization available")
                    }
                    .font(.body)
                }
            }
            .padding()
        }
        .navigationTitle("README CSS Styling")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        READMECSSStyling()
    }
}
