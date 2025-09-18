//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct EmptyAttributeStyle: AttributeStyleable {
    func applyStyles(attributes: [String: AttributeValue], to styleContainer: inout HTMLStyleContainer) {

    }

    func layoutStyle(attributes: [String: AttributeValue]) -> EmptyViewModifier {
        EmptyViewModifier()
    }

    struct EmptyViewModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
        }
    }
}
