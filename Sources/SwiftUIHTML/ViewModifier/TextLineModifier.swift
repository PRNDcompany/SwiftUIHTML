//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


struct TextLineModifier: ViewModifier {
    typealias TextLine = HTMLInline.TextLine
    @HTMLEnvironment(\.styleContainer) var styleContainer
    let textLine: TextLine

    func body(content: Content) -> some View {
        content
            .lineSpacing(lineSpacing)
            .padding(.vertical, verticalPadding)
    }

    var lineSpacing: CGFloat {
        max(textLine.lineSpacing, styleContainer.textLine?.lineSpacing ?? 0)
    }

    var verticalPadding: CGFloat {
        max(textLine.verticalPadding, styleContainer.textLine?.verticalPadding ?? 0)
    }
}
