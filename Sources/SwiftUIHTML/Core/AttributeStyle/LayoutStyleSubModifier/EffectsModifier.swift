//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct EffectsModifier: ViewModifier {
    let cssStyle: CSSStyle
    
    func body(content: Content) -> some View {
        content
            .modifier(ShadowModifier(cssStyle: cssStyle))
            .opacity(cssStyle["opacity"]?.cgFloat ?? 1.0)
    }
}

private struct ShadowModifier: ViewModifier {
    let cssStyle: CSSStyle
    
    func body(content: Content) -> some View {
        if let boxShadow = cssStyle["box-shadow"]?.string {
            let shadow = parseShadow(boxShadow)
            content.shadow(
                color: shadow.color,
                radius: shadow.radius,
                x: shadow.x,
                y: shadow.y
            )
        } else {
            content
        }
    }
    
    private func parseShadow(_ boxShadow: String) -> (color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
        var color: Color = .black.opacity(0.33)
        var radius: CGFloat = 3
        var x: CGFloat = 0
        var y: CGFloat = 2
        
        if boxShadow.lowercased() == "none" || boxShadow.lowercased() == "initial" {
            return (Color.clear, 0, 0, 0)
        }
        
        if let colorMatch = boxShadow.range(of: "rgba?\\([^)]+\\)|#[0-9a-fA-F]{3,8}|[a-zA-Z]+", options: .regularExpression) {
            let colorString = String(boxShadow[colorMatch])
            color = Color(cssString: colorString) ?? color
        }
        
        return (color, radius, x, y)
    }
    
    
}
