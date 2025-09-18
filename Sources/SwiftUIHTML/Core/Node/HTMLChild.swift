//  Copyright © 2024 PRND. All rights reserved.
import Foundation


public enum HTMLChild: Equatable, Sendable {
    case text(String)
    case node(HTMLNode)
}

public extension HTMLChild {
    static var newLine: HTMLChild {
        .text("\n")
    }

    static func trimmingText(_ string: String) -> HTMLChild {
        .text(string.trimmingCharacters(in: .trimmableSpaces))
    }
}

// MARK - private
private extension CharacterSet {
    static var trimmableSpaces: CharacterSet {
        CharacterSet
            .whitespacesAndNewlines
            .subtracting(CharacterSet(charactersIn: "\u{00A0}"))
    }
}
