// Copyright © 2025 PRND. All rights reserved.


enum TextType: Hashable {
    case text(_ string: String, styleContainer: HTMLStyleContainer)
    case newLine(styleContainer: HTMLStyleContainer)
    case attachment(
        id: AnyHashable,
        tag: String,
        attributes: [String: AttributeValue],
        styleContainer: HTMLStyleContainer
    )
}

extension TextType {
    var hasAttachment: Bool {
        switch self {
        case .attachment: return true
        default: return false
        }
    }

}
