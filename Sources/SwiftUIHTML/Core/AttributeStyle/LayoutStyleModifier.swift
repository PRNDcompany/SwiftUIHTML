//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct LayoutStyleModifier: ViewModifier {
    let cssStyle: CSSStyle
    
    func body(content: Content) -> some View {
        content
            .modifier(EdgeModifier(property: "padding", cssStyle: cssStyle))
            .modifier(InnerLayoutModifier(cssStyle: cssStyle))
            .modifier(BackgroundModifier(cssStyle: cssStyle))
            .modifier(BorderModifier(cssStyle: cssStyle))
            .compositingGroup()
            .modifier(EffectsModifier(cssStyle: cssStyle))
            .modifier(EdgeModifier(property: "margin", cssStyle: cssStyle))
    }
}
