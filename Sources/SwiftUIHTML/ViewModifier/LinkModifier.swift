// Copyright © 2025 PRND. All rights reserved.
import SwiftUI


struct LinkModifier: ViewModifier {
    let link: URL?
    
    @Environment(\.openURL) var openURL
    func body(content: Content) -> some View {
        if let link {
            content.onTapGesture {
                openURL(link)
            }
        } else {
            content
        }
    }
}
