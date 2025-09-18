//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


extension HTMLStyleContainer {
    public enum TextLineAttribute: Equatable, Sendable, Hashable {
        case lineSpacing(spacing: CGFloat)
        case lineHeight(fontLineHeight: CGFloat, lineHeight: CGFloat)
    }
}

public extension HTMLStyleContainer.TextLineAttribute {
    static func lineHeight(font: UIFont, lineHeight: CGFloat) -> Self {
        .lineHeight(fontLineHeight: font.lineHeight, lineHeight: lineHeight)
    }
}

extension HTMLStyleContainer.TextLineAttribute {
    var lineSpacing: CGFloat {
        switch self {
        case let .lineHeight(fontLineHeight, lineHeight):
            let value = lineHeight - fontLineHeight
            return CGFloat(round(10 * value) / 10)
        case let .lineSpacing(spacing):
            return spacing
        }
    }

    var verticalPadding: CGFloat? {
        switch self {
        case let .lineHeight(fontLineHeight, lineHeight):
            let value = (lineHeight - fontLineHeight) / 2
            return CGFloat(round(10 * value) / 10)
        case .lineSpacing:
            return nil
        }
    }

    var lineHeight: CGFloat? {
        switch self {
        case let .lineHeight(_, lineHeight):
            return lineHeight
        case .lineSpacing:
            return nil
        }
    }
}
