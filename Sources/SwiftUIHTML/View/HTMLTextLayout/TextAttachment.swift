//  Copyright © 2025 PRND. All rights reserved.
import UIKit

final class TextAttachment: NSTextAttachment {

    let key: AnyHashable
    let font: UIFont?
    let textLine: HTMLStyleContainer.TextLineAttribute?

    init(
        key: AnyHashable,
        styleContainer: HTMLStyleContainer
    ) {
        self.key = key
        self.font = styleContainer.uiFont
        self.textLine = styleContainer.textLine
        super.init(data: nil, ofType: nil)
        self.image = UIImage()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateSize(_ size: CGSize) {
        guard size.width > 1 && size.height > 1 else {
            bounds = CGRect(origin: .zero, size: .invisible)
            return
        }
        bounds = CGRect(origin: .zero, size: size)
    }

    func getAdjustedSize() -> CGSize {
        guard let font else { return bounds.size }
        let targetHeight = round(CTFontGetBoundingBox(font).maxY)
        var adjustedHeight = bounds.size.height

        switch textLine {
        case let .lineHeight(_, lineHeight):
            adjustedHeight += targetHeight - lineHeight
        case .lineSpacing, .none:
            adjustedHeight += targetHeight - font.lineHeight
        }
        
        return CGSize(
            width: bounds.size.width,
            height: max(targetHeight, adjustedHeight)
        )
    }

    func getAdjustedOffset(point: CGPoint) -> CGPoint {
        guard let font else { return point }
        let fontHeight = font.ascender + font.descender

        let boundHeight = bounds.size.height
        let lineHeight = textLine?.lineHeight ?? fontHeight

        var verticalOffset = (boundHeight - fontHeight) / 2

        if lineHeight < boundHeight {
            verticalOffset -= (boundHeight - lineHeight) / 2
        }

        return CGPoint(x: point.x, y: point.y - boundHeight + verticalOffset)
    }

}

private extension UIFont {
    var fontHeight: CGFloat {
        let ascent = CTFontGetAscent(self)
        let descent = CTFontGetDescent(self)
        return ascent + descent
    }
}
