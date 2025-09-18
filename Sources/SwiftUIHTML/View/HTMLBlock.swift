//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


public struct HTMLBlock: View {
    enum GroupContent: Equatable {
        case block(BlockElement)
        case inline([InlineElement])
    }

    let element: BlockElement

    @HTMLEnvironment(\._configuration) var configuration

    public init(element: BlockElement) {
        self.element = element
    }

    public var body: some View {
        ForEach(groupContents(contents: element.contents).indicesCollection, id: \.0) { _, groupContent in
            renderContent(groupContent)
        }
    }
}

// MARK: - private
private extension HTMLBlock {
    @ViewBuilder
    func renderContent(_ groupContent: GroupContent) -> some View {
        switch groupContent {
        case .block(let childElement):
            VStack(alignment: .leading, spacing: .zero) {
                configuration
                    .createBlock(element: childElement)
            }
            .modifier(
                configuration.attributeStyle
                    .eraseToAnyLayoutModifier(attributes: childElement.attributes)
            )
        case .inline(let elements):
            renderInline(elements: elements)
        }
    }

    @ViewBuilder
    func renderInline(elements: [InlineElement]) -> some View {
        // attachment 만 독립적으로 있는경우는 Inline 말고 View로 render
        if elements.count == 1, let element = elements.first, case .attachment = element.type {
            configuration.createAttachment(for: element.tag, with: element.attributes)
                .modifier(LinkModifier(link: element.styleContainer.link))
        } else {
            HTMLInline(elements: elements)
        }
    }

    func groupContents(contents: [TagElement]) -> [GroupContent] {
        var result: [GroupContent] = []
        var currentInlineGroup: [InlineElement] = []

        contents.forEach { content in
            switch content {
            case let .block(blockElement):
                if !currentInlineGroup.isEmpty {
                    result.append(.inline(currentInlineGroup))
                    currentInlineGroup.removeAll()
                }
                result += [.block(blockElement)]

            case let .inline(inlineElement):
                currentInlineGroup += [inlineElement]
            }
        }

        if !currentInlineGroup.isEmpty {
            result.append(.inline(currentInlineGroup))
        }

        return result
    }
}

extension HTMLBlock: @preconcurrency Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.element == rhs.element
    }
}
