//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


public struct HTMLText: View {
    let text: String

    @HTMLEnvironment(\.styleContainer) var styleContainer

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        Text(AttributedString(
            text,
            attributes: styleContainer.toAttributeContainer()
        ))
        .modifier(TextLineModifier(textLine: HTMLInline.TextLine(
            lineSpacing: styleContainer.textLine?.lineSpacing ?? .zero,
            verticalPadding: styleContainer.textLine?.verticalPadding ?? .zero
        )))
    }
}
