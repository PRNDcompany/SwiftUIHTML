//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


struct LinkTag: InlineTag {

    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        guard let href = attributes["href"] else { return }
        
        styleContainer.link = href.url
        styleContainer.foregroundColor = nil
        styleContainer.underlineStyle = .single
    }
}
