//  Copyright © 2024 PRND. All rights reserved.
import UIKit
import Combine

final class AttachmentLayoutEngine {
    
    @Published var attributedString: NSMutableAttributedString?
    @Published private var containerSize: CGSize?

    private var keyAttachment: [AnyHashable: Weak<TextAttachment>] = [:]
    private var frameStore: [AnyHashable: CGRect] = [:]
    private var texts: [TextType] = []
    private var textRangeFrameCalculator = TextRangeFrameCalculator()
    private var cancelBag = Set<AnyCancellable>()

    var lineSpacing: CGFloat {
        get { textRangeFrameCalculator.lineSpacing }
        set { textRangeFrameCalculator.lineSpacing = newValue }
    }

    let layoutUpdatePublisher = PassthroughSubject<Void, Never>()

    init() {
        setup()
    }

    func setup() {
        let attributedStringPublisher = _attributedString.projectedValue
            .compactMap { $0 }
            .removeDuplicates()
        
        let containerSizePublisher = _containerSize.projectedValue
            .compactMap { $0 }
            .removeDuplicates()

        Publishers
            .CombineLatest(attributedStringPublisher, containerSizePublisher)
            .map { [unowned self] in
                measureLayoutPublisher(attributedString: $0, containerSize: $1)
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.storeRangeBounds(result)
            }
            .store(in: &cancelBag)
    }

    func setSize(key: AnyHashable, size: CGSize) {
        guard let textAttachment = keyAttachment[key] else { return }
        let oldSize = textAttachment.value?.bounds.size ?? .zero
        guard oldSize != size else { return }
        textAttachment.value?.updateSize(size)
        layoutUpdatePublisher.send(())
    }

    func getSize(key: AnyHashable) -> CGSize {
        guard let textAttachment = keyAttachment[key] else { return .zero }
        return textAttachment.value?.getAdjustedSize() ?? .zero
    }

    func getOffset(key: AnyHashable) -> CGPoint {
        let point = frameStore[key]?.origin ?? .zero
        guard let textAttachment = keyAttachment[key] else { return point }
        return textAttachment.value?.getAdjustedOffset(point: point) ?? point

    }

    func setContainerSize(_ size: CGSize) {
        containerSize = size
    }

    @MainActor
    func setTexts(_ texts: [TextType]) {
        let hasAttachment = !texts.lazy.filter(\.hasAttachment).isEmpty
        guard hasAttachment else {
            self.texts = []
            self.attributedString = nil
            return
        }
        
        guard self.texts != texts else { return }
        self.texts = texts
        attributedString = makeAttributedString(texts: texts)
    }


}

private extension AttachmentLayoutEngine {
    func set(key: AnyHashable, attachment: TextAttachment) {
        guard let _attachment = keyAttachment[key] else {
            keyAttachment[key] = Weak(value: attachment)
            return
        }
        _attachment.value = attachment
    }

    @MainActor
    func makeAttributedString(texts: [TextType]) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString()

        for element in texts {
            switch element {
            case let .text(string, styleContainer):
                let text = makeAttributedString(
                    string: string,
                    styleContainer: styleContainer
                )
                attributedString.append(text)

            case let .newLine(styleContainer):
                let text = makeAttributedString(
                    string: "\n",
                    styleContainer: styleContainer
                )
                attributedString.append(text)

            case let .attachment(_, _, _, styleContainer):
                let attachment = TextAttachment(
                    key: element,
                    styleContainer: styleContainer
                )
                let attachmentString = NSMutableAttributedString(attachment: attachment)
                attachmentString.addAttributes(by: styleContainer)

                attributedString.append(attachmentString)
                set(key: element, attachment: attachment)
            }
        }

        return attributedString
    }

    func makeAttributedString(string: String, styleContainer: HTMLStyleContainer) -> NSMutableAttributedString {
        let value = AttributedString(string, attributes: styleContainer.toAttributeContainer())
        let text = NSMutableAttributedString(value)
        text.addAttributes(by: styleContainer)
        return text
    }


    func measureLayoutPublisher(attributedString: NSMutableAttributedString, containerSize: CGSize) -> AnyPublisher<[(AnyHashable, CGRect)], Never> {
        let coreTextString = textRangeFrameCalculator
            .prepareCoreTextString(attributedString)

        let targets = textRangeFrameCalculator
            .findAttribute(in: attributedString, for: .attachment, type: TextAttachment.self)

        let attchmentSizeChange = targets
            .map { target in
                target.value
                    .publisher(for: \.bounds)
                    .removeDuplicates()
                    .filter { $0.size > .invisible }
            }

        let keys = targets.map(\.value.key)
        let ranges = targets.map(\.range)

        return Publishers.MergeMany(attchmentSizeChange)
            .receive(on: DispatchQueue.global(qos: .background))
            .compactMap { [weak textRangeFrameCalculator] _ in
                textRangeFrameCalculator?
                    .measureLayout(for: coreTextString, in: containerSize, by: ranges)
            }
            .map { zip(keys, $0).map { ($0, $1) } }
            .eraseToAnyPublisher()
    }


    func storeRangeBounds(key: AnyHashable, bounds: CGRect) {
        frameStore[key] = bounds
        layoutUpdatePublisher.send(())
    }

    func storeRangeBounds(_ values: [(key: AnyHashable, bounds: CGRect)]) {
        values.forEach {
            frameStore[$0.key] = $0.bounds
        }
        layoutUpdatePublisher.send(())
    }
}


private extension NSMutableAttributedString {
    func addAttributes(by styleContainer: HTMLStyleContainer) {
        var attributes: [NSAttributedString.Key: Any] = [:]

        if let kern = styleContainer.kern {
            attributes[.kern] = kern
        }
        if let tracking = styleContainer.tracking {
            attributes[.tracking] = tracking
        }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byWordWrapping
        paragraphStyle.lineBreakStrategy = .standard

        paragraphStyle.lineSpacing = styleContainer.textLine?.lineSpacing ?? 0
        attributes[.paragraphStyle] = paragraphStyle

        addAttributes(attributes, range: NSRange(location: 0, length: length))
    }
}
