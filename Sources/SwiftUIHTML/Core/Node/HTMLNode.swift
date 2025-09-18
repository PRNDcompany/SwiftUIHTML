//  Copyright © 2024 PRND. All rights reserved.
import Foundation


public struct HTMLNode: Equatable, Sendable {
    let tag: String
    let attributes: [String: AttributeValue]
    let children: [HTMLChild]

    public init(tag: String, attributes: [String: String] = [:], children: [HTMLChild] = []) {
        self.tag = tag
        self.attributes = attributes.mapValues { AttributeValue(rawValue: $0) }
        self.children = children
    }
}


extension HTMLNode {
    @MainActor
    func toElement(
        configuration: HTMLConfiguration,
        with styleContainer: HTMLStyleContainer
    ) -> BlockElement {
        let contents = children.flatMap { child -> [TagElement] in
            child.toElement(
                configuration: configuration,
                with: styleContainer
            )
        }
        return BlockElement(
            tag: tag,
            attributes: attributes,
            contents: contents,
            styleContainer: styleContainer
        )
    }


}


fileprivate extension HTMLChild {
    @MainActor
    func toElement(configuration: HTMLConfiguration, with styleContainer: HTMLStyleContainer) -> [TagElement] {
        switch self {
        case let .text(text) where text.isEmpty:
            return []

        case let .text(text):
            return [
                .inline(InlineElement(
                    tag: "_text",
                    attributes: [:],
                    text: text,
                    styleContainer: styleContainer
                ))
            ]

        case let .node(childNode):
            return childNode
                .makeElement(
                    configuration: configuration,
                    with: styleContainer
                )
        }
    }
}


fileprivate extension HTMLNode {
    @MainActor
    func makeElement(configuration: HTMLConfiguration, with styleContainer: HTMLStyleContainer) -> [TagElement] {
        var _styleContainer = styleContainer
        configuration.applyStyles(tag: tag, attributes: attributes, to: &_styleContainer)

        switch configuration.tagType(of: tag) {
        case .inline:
            return children
                .flatMap { child -> [TagElement] in
                    child.toElement(
                        configuration: configuration,
                        with: _styleContainer
                    )
                }

        case .attachment:
            return [
                .inline(InlineElement(
                    tag: tag,
                    attributes: attributes,
                    type: .attachment,
                    styleContainer: _styleContainer
                ))
            ]

        case .block, .none:
            return [
                .block(toElement(
                    configuration: configuration,
                    with: _styleContainer
                ))
            ]
        }
    }
}
