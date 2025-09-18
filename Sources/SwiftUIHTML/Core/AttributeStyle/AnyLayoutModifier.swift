//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI

struct AnyLayoutModifier: ViewModifier {
    private let _body: (Content) -> AnyView

    init<T: ViewModifier>(_ modifier: T) {
        self._body = { content in
            AnyView(content.modifier(modifier))
        }
    }

    func body(content: Content) -> some View {
        _body(content)
    }
}

extension AttributeStyleable {
    @MainActor
    func eraseToAnyLayoutModifier(attributes: [String: AttributeValue]) -> AnyLayoutModifier {
        AnyLayoutModifier(layoutStyle(attributes: attributes))
    }
}
