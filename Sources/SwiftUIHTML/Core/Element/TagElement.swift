//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


@MainActor
public enum TagElement: Equatable, Hashable {
    case inline(InlineElement)
    case block(BlockElement)
}

public extension TagElement {
    var tag: String {
        switch self {
        case .inline(let element):
            element.tag
        case .block(let element):
            element.tag
        }
    }
    
    var attributes: [String: AttributeValue] {
        switch self {
        case .inline(let element):
            element.attributes
        case .block(let element):
            element.attributes
        }
    }
}
