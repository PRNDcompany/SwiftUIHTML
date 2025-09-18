//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


public struct DefaultAttributeStyler: AttributeStyleable {
    public init() {

    }

    public func layoutStyle(attributes: [String: AttributeValue]) -> some ViewModifier {
        let cssStyle = attributes["style"]?.cssStyle ?? .empty
        return LayoutStyleModifier(cssStyle: cssStyle)
    }

    public func applyStyles(
        attributes: [String : AttributeValue],
        to styleContainer: inout HTMLStyleContainer
    ) {
        let cssStyle = attributes["style"]?.cssStyle ?? .empty

        if let color = cssStyle["color"]?.toColor() {
            styleContainer.foregroundColor = color
        }

        if let color = cssStyle["background-color"]?.toColor() {
            styleContainer.backgroundColor = color
        }

        if let newFont = CSSFontUtility.createFont(
            fromCSSStyle: cssStyle,
            currentFont: styleContainer.uiFont
        ) {
            styleContainer.uiFont = newFont
        }

        if let lineHeight = cssStyle["line-height"]?.cgFloat, let font = styleContainer.uiFont {
            styleContainer.textLine = .lineHeight(font: font, lineHeight: lineHeight)
        } else if let lineSpacing = cssStyle["line-spacing"]?.cgFloat {
            styleContainer.textLine = .lineSpacing(spacing: lineSpacing)
        }

        if let wordBreak = cssStyle["word-break"]?.string {
            switch wordBreak {
            case "break-all":
                styleContainer.lineBreakMode = .byCharWrapping
            case "inherit":
                break // Noting
            default:
                styleContainer.lineBreakMode = .byWordWrapping
            }
        }
    }
}
