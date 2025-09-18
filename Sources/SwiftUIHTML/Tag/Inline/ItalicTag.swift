//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


struct ItalicTag: InlineTag {
    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        styleContainer.inlinePresentationIntent = styleContainer.inlinePresentationIntent
            .map { [$0, .emphasized] } ?? .emphasized
    }
}
