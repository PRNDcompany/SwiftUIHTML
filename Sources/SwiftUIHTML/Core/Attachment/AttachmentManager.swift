// Copyright © 2025 PRND. All rights reserved.
import UIKit
import Combine


final class AttachmentManager: ObservableObject {
    lazy var layoutEngine = AttachmentLayoutEngine()
    private var cancellables = Set<AnyCancellable>()

    private class ImageCache: NSCache<AttachmentImageCacheKey, UIImage> {}
    private let textImages = ImageCache()

    init() {
        layoutEngine.layoutUpdatePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }

    @MainActor
    func setTexts(_ texts: [TextType]) {
        layoutEngine.setTexts(texts)
    }

    @MainActor
    func setContainer(size: CGSize)  {
        layoutEngine.setContainerSize(size)
    }

    func setAttachmentSize(key: AnyHashable, size: CGSize, styleContainer: HTMLStyleContainer) {
        layoutEngine.setSize(key: key, size: size)
        //NOTE: lineSpacing 각각 다를 수 있음
        layoutEngine.lineSpacing = styleContainer.textLine?.lineSpacing ?? 0
    }

    func offset(key: AnyHashable) -> CGSize {
        let point = layoutEngine.getOffset(key: key)
        return CGSize(width: point.x, height: point.y)
    }

    // SwiftUI Text(image:) 주입 이미지
    func sizeImage(key: AnyHashable, styleContainer: HTMLStyleContainer) -> UIImage {
        var size = layoutEngine.getSize(key: key)
        var fontName: String? = nil
        var fontSize: CGFloat? = nil
        if let uiFont = styleContainer.uiFont {
            fontName = uiFont.fontName
            fontSize = uiFont.pointSize
        }
        let cacheKey = AttachmentImageCacheKey(
            key: key,
            size: size,
            fontName: fontName,
            fontSize: fontSize
        )
        if let image = textImages.object(forKey: cacheKey) {
            return image
        }
        let image = EmptyImage(size: size).image
        textImages.setObject(image, forKey: cacheKey)
        return image
    }

    func clearImageCache() {
        textImages.removeAllObjects()
    }
}

private extension AttachmentManager {
}

private struct EmptyImage {
    let scale: CGFloat
    let size: CGSize

    init(scale: CGFloat = 1, size: CGSize) {
        self.scale = scale
        self.size = size
    }

    var image: UIImage {
        if size == .zero { return UIImage() }
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let renderer = UIGraphicsImageRenderer(size: size, format: format)
        return renderer.image { _ in }
    }
}

// 복합 캐시 키 정의
private final class AttachmentImageCacheKey: NSObject {
    let key: AnyHashable
    let size: CGSize
    let fontName: String?
    let fontSize: CGFloat?

    init(key: AnyHashable, size: CGSize, fontName: String?, fontSize: CGFloat?) {
        self.key = key
        self.size = size
        self.fontName = fontName
        self.fontSize = fontSize
    }

    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? AttachmentImageCacheKey else { return false }
        return key == other.key && size == other.size && fontName == other.fontName && fontSize == other.fontSize
    }

    override var hash: Int {
        var hasher = Hasher()
        hasher.combine(key)
        hasher.combine(size.width)
        hasher.combine(size.height)
        hasher.combine(fontName)
        hasher.combine(fontSize)
        return hasher.finalize()
    }
}
