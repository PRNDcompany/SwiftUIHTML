//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI

struct HTMLTextLayout: View {
    var texts: [TextType]
    
    @ObservedObject var attachmentManager: AttachmentManager
    @HTMLEnvironment(\._configuration) var configuration

    init(attachmentManager: AttachmentManager, texts: [TextType]) {
        self.texts = texts
        self.attachmentManager = attachmentManager
        attachmentManager.setTexts(texts)
    }

    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .modifier(OnChangeViewModifier(of: proxy.size, initial: true) { _, newValue in
                    attachmentManager.setContainer(size: proxy.size)
                })
            ForEach(attachmentTexts, id: \.hashValue) { text in
                attachmentView(for: text)
            }
        }
    }

    private var attachmentTexts: [TextType] {
        texts.filter(\.hasAttachment)
    }

    @ViewBuilder
    private func attachmentView(for text: TextType) -> some View {
        if let info = extractAttachmentInfo(from: text) {
            info.view
                .modifier(LinkModifier(link: info.link))
                .offset(attachmentManager.offset(key: text))
                .background(attachmentSizeReader(for: text, styleContainer: info.styleContainer))
        }
    }

    private func extractAttachmentInfo(from text: TextType) -> (view: AnyView, link: URL?, styleContainer: HTMLStyleContainer)? {
        if case let .attachment(_, tag, attributes, styleContainer) = text,
           let view = configuration.createAttachment(for: tag, with: attributes) {
            return (view: AnyView(view), link: styleContainer.link, styleContainer: styleContainer)
        }
        return nil
    }

    private func attachmentSizeReader(for text: TextType, styleContainer: HTMLStyleContainer) -> some View {
        GeometryReader { proxy in
            Color.clear
                .hidden()
                .modifier(OnChangeViewModifier(of: proxy.size, initial: true) { _, newValue in
                    attachmentManager.setAttachmentSize(
                        key: text,
                        size: newValue,
                        styleContainer: styleContainer
                    )
                })
        }
    }
}
