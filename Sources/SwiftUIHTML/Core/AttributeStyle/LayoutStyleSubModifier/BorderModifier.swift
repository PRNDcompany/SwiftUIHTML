//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct BorderModifier: ViewModifier {
    let cssStyle: CSSStyle

    func body(content: Content) -> some View {
        if let radius = cssStyle["border-radius"]?.cgFloat, radius > 0 {
            content
                .clipShape(RoundedRectangle(cornerRadius: radius))
                .overlay(getBorderOverlay(radius: radius))
        } else {
            content
                .overlay(getBorderOverlay(radius: 0))
        }
    }

}

extension BorderModifier {
    @ViewBuilder
    func getBorderOverlay(radius: CGFloat) -> some View {
        if shouldShowBorder() {
            let color = cssStyle["border-color"]?.toColor() ?? .black
            let width = cssStyle["border-width"]?.cgFloat ?? 1

            if radius > 0 {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: width)
            } else {
                Rectangle()
                    .stroke(color, lineWidth: width)
            }
        } else {
            EmptyView()
        }
    }

    func shouldShowBorder() -> Bool {
        if let borderStyle = cssStyle["border"]?.string, borderStyle != "none" {
            return true
        }

        if let borderWidth = cssStyle["border-width"]?.cgFloat, borderWidth > 0 {
            return true
        }

        return false
    }
}
