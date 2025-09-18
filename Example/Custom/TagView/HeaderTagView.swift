//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI

import SwiftUIHTML


struct HeaderTagView: BlockTag {
    var element: BlockElement
    
    init(element: BlockElement) {
        self.element = element
    }

    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        styleContainer.foregroundColor = .green
        styleContainer.underlineStyle = .single
        styleContainer.backgroundColor = .blue
    }
}
