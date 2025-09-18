//  Copyright © 2025 PRND. All rights reserved.
import UIKit

import SwiftUIHTML

extension HTMLStyleContainer {
    static func sample(by lineBreakMode: LineBreakMode) -> HTMLStyleContainer {
        var style = HTMLStyleContainer()
        let font = UIFont.systemFont(ofSize: 12)
        style.uiFont = font
        style.textLine = .lineHeight(font: font, lineHeight: 24)
        style.lineBreakMode = lineBreakMode
        return style
    }
}

extension HTMLConfiguration {
    @MainActor
    static var sample: HTMLConfiguration {
        .default
        .register(tag: "h1", renderer: Headinglevel1TagView.self)
        .register(tag: "h2", renderer: Headinglevel2TagView.self)
        .register(tag: "h3", renderer: Headinglevel3TagView.self)
        .register(tag: "header", renderer: HeaderTagView.self)
        .register(tag: "ul", renderer: ULTagView.self)
        .register(tag: "video", renderer: VideoTagView.self)

        .attributeStyler(DefaultAttributeStyler())
    }
}
