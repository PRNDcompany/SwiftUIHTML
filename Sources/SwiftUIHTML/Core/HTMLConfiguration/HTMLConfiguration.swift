//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


public struct HTMLConfiguration: Sendable {
    enum TagType {
        case block
        case inline
        case attachment
    }

    var dictionary: [String: HTMLTagElementable.Type] = [:]
    var dictionaryType: [String: TagType] = [:]
    var attributeStyle: any AttributeStyleable = EmptyAttributeStyle()

    public init() {
        // 최소한 정의
        self = register(
            tag: "div", "body", "p", "header", "main", "section", "footer", "h1", "h2",
            renderer: DefaultBlockTag.self
        )
        .register(
            tag: "span",
            renderer: DefaultInlineTag.self
        )
        .register(
            tag: "a",
            renderer: LinkTag.self
        )
        .register(
            tag: "b", "strong",
            renderer: BoldTag.self
        )
        .register(
            tag: "i", "em",
            renderer: ItalicTag.self
        )
        .register(
            tag: "u",
            renderer: UnderlineTag.self
        )
        .register(tag: "img", renderer: ImageTag.self)
    }
}

extension HTMLConfiguration {
    public func attributeStyler(_ style: any AttributeStyleable) -> Self {
        var copy = self
        copy.attributeStyle = style
        return copy
    }
}


// MARK: - Internal Helper
@MainActor
extension HTMLConfiguration {
    func tagType(of tag: String) -> TagType? {
        dictionaryType[tag]
    }

    func applyStyles(tag: String, attributes: [String: AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        attributeStyle.applyStyles(attributes: attributes, to: &styleContainer)
        dictionary[tag]?.applyStyles(with: attributes, to: &styleContainer)
    }

    @ViewBuilder
    func createBlock(element: BlockElement) -> some View {
        if let view = dictionary[element.tag] as? any BlockTag.Type  {
            AnyView(view.init(element: element))
        }
    }


    @MainActor
    func createAttachment(for tag: String, with attributes: [String: AttributeValue]) -> AnyView? {
        guard let view = dictionary[tag] as? any InlineAttachmentTag.Type else {
            return nil
        }
        return AnyView(view.init(attributes: attributes))
    }
}
