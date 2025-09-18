//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


struct UnderlineTag: InlineTag {
    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        styleContainer.underlineStyle = .single

        if let underlineColor = attributes["underline-color"]?.toColor() {
            styleContainer.underlineColor = UIColor(underlineColor)
        }
    }
}

