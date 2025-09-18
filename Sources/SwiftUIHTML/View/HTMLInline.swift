//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


struct HTMLInline: View {
    struct TextLine {
        let lineSpacing: CGFloat
        let verticalPadding: CGFloat
    }

    let texts: [TextType]
    @StateObject var attachmentManager = AttachmentManager()

    init(elements: [InlineElement]) {
        self.init(texts: elements.toHTMLTextType())
    }

    init(texts: [TextType]) {
        self.texts = texts.trimmingNewLines()
    }

    var body: some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .overlay(alignment: .topLeading) { htmlTextLayout }
            .modifier(TextLineModifier(textLine: textLine))
    }

    @ViewBuilder
    var htmlTextLayout: some View {
        if hasAttachment {
            HTMLTextLayout(
                attachmentManager: attachmentManager,
                texts: texts
            )
        }
    }

    var hasAttachment: Bool {
        !texts.lazy.filter(\.hasAttachment).isEmpty
    }
  
    var content: some View {
        texts
            .reduce(Text("")) { result, type in
                switch type {
                case let .text(string, container):
                    return result + Text(AttributedString(
                        string,
                        attributes: container.toAttributeContainer()
                    ))
                case let .newLine(container):
                    return result + Text(AttributedString(
                        "\n",
                        attributes: container.toAttributeContainer()
                    ))
                    
                case let .attachment(_, _, _, styleContainer):
                    return result + (
                        Text(
                            Image(uiImage: attachmentManager.sizeImage(
                                key: type,
                                styleContainer: styleContainer
                            ))
                        ).font(.system(size: 1))
                    )
                }
            }
    }

}

extension HTMLInline {
    var textLine: TextLine {
        let result: [HTMLStyleContainer.TextLineAttribute] = texts.compactMap {
            guard case .text(_, let attributes) = $0, let textLine = attributes.textLine else { return nil }
            return textLine
        }

        return TextLine(
            lineSpacing: result.compactMap(\.lineSpacing).max() ?? 0,
            verticalPadding: result.compactMap(\.verticalPadding).max() ?? 0
        )
    }
}

extension HTMLInline: @preconcurrency Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.texts == rhs.texts
    }
}

private extension Array where Element == TextType {
    // TextType의 마지막 newLine 제거
    // HTMLInline 에서 마지막이 newLine이 있다면 줄바꿈이 필요없음
    func trimmingNewLines() -> [Element] {

        // 뒤쪽의 .newLine 제거
        if let last, case .newLine = last {
            return dropLast()
        }
        return self
    }
}
