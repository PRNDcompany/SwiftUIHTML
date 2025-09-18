//  Copyright © 2024 PRND. All rights reserved.
import Foundation


@MainActor
public struct InlineElement: Sendable, Hashable {
    enum ElementType: Hashable {
        case text(_ string: String)
        case attachment
    }
    public let tag: String
    public let attributes: [String: AttributeValue]
    
    let type: ElementType
    let styleContainer: HTMLStyleContainer

    init(tag: String, attributes: [String : AttributeValue], type: ElementType, styleContainer: HTMLStyleContainer) {
        self.tag = tag
        self.attributes = attributes
        self.type = type
        self.styleContainer = styleContainer
    }

    init(tag: String, attributes: [String : AttributeValue], text: String, styleContainer: HTMLStyleContainer) {
        self.tag = tag
        self.attributes = attributes
        self.styleContainer = styleContainer
        self.type = .text(styleContainer.lineBreakMode(text))
    }
}


extension Collection where Element == InlineElement {
    
    @MainActor
    func toHTMLTextType() -> [TextType] {
        var textCount = 0
        var attachmentCount = 0

        return map { element in
            switch element.type {
            case .text:
                defer { textCount += 1 }
                return element.toHTMLTextType(id: textCount)
            case .attachment:
                defer { attachmentCount += 1 }
                return element.toHTMLTextType(id: attachmentCount)
            }
        }
    }
}

extension InlineElement {
    func toHTMLTextType<Id: Hashable>(id: Id) -> TextType {
        switch type {
        case let .text(string) where string == "\n":
            return .newLine(styleContainer: styleContainer)
        case let .text(string):
            return .text(string, styleContainer: styleContainer)
        case .attachment:
            return .attachment(
                id: id,
                tag: tag,
                attributes: attributes,
                styleContainer: styleContainer
            )
        }
    }
}

extension InlineElement: @preconcurrency CustomDebugStringConvertible {
    public var debugDescription: String {
        switch type {
        case let .text(string):
            return "\(string)"
        case .attachment:
            return "[attachment:\(tag),\(attributes)]"
        }
    }
}
