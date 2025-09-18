//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct InnerLayoutModifier: ViewModifier {
    let cssStyle: CSSStyle

    func body(content: Content) -> some View {
        content
            .frame(
                minWidth: cssStyle["min-width"]?.cgFloat,
                idealWidth: cssStyle["width"]?.cgFloat,
                maxWidth: cssStyle["max-width"]?.cgFloat,
                minHeight: cssStyle["min-height"]?.cgFloat,
                idealHeight: cssStyle["height"]?.cgFloat,
                maxHeight: cssStyle["max-height"]?.cgFloat,
                alignment: getAlignment()
            )
    }
}

private extension InnerLayoutModifier {
    func getAlignment() -> Alignment {
       if let alignValue = cssStyle["align"]?.string {
           switch alignValue {
           case "center":
               return .center
           case "left":
               return .leading
           case "right":
               return .trailing
           default:
               return .center
           }
       }
       return .center
   }
}
