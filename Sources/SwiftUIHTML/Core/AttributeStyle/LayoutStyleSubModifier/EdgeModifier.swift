//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct EdgeModifier: ViewModifier {
    let property: String
    let cssStyle: CSSStyle

    func body(content: Content) -> some View {
        content
            .padding(getEdgeInsets(for: property))
    }
}

private extension EdgeModifier {
    private func getEdgeInsets(for property: String) -> EdgeInsets {
        if let insets = cssStyle[property]?.toEdgeInsets() {
            return insets
        } else if let value = cssStyle[property]?.cgFloat {
            return EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
        }

        let top = cssStyle["\(property)-top"]?.cgFloat ?? 0
        let right = cssStyle["\(property)-right"]?.cgFloat ?? 0
        let bottom = cssStyle["\(property)-bottom"]?.cgFloat ?? 0
        let left = cssStyle["\(property)-left"]?.cgFloat ?? 0

        guard top > 0 || right > 0 || bottom > 0 || left > 0 else { return EdgeInsets() }
        return EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
