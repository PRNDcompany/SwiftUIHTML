//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct BackgroundModifier: ViewModifier {
    let cssStyle: CSSStyle

    func body(content: Content) -> some View {
        content
            .background(getBackgroundColor())
    }
}


private extension BackgroundModifier {
    func getBackgroundColor() -> Color? {
       cssStyle["background-color"]?.toColor() ?? cssStyle["background"]?.toColor()
   }
}
