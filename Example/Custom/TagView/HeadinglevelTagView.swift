//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI

import SwiftUIHTML

struct Headinglevel1TagView: BlockTag {
    var element: BlockElement

    init(element: BlockElement) {
        self.element = element
    }

    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        styleContainer.uiFont = UIFont.boldSystemFont(ofSize: 24)
    }
}

struct Headinglevel2TagView: BlockTag {
    var element: BlockElement
    @HTMLEnvironment(\.styleContainer) var styleContainer

    init(element: BlockElement) {
        self.element = element
    }
    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        styleContainer.uiFont = UIFont.boldSystemFont(ofSize: 20)
    }
}

struct Headinglevel3TagView: BlockTag {
    var element: BlockElement
    @HTMLEnvironment(\.styleContainer) var styleContainer

    init(element: BlockElement) {
        self.element = element
    }

    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        styleContainer.uiFont = UIFont.boldSystemFont(ofSize: 18)
    }
}
