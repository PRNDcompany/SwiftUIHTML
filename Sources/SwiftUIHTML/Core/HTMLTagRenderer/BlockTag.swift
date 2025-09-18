//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


public protocol BlockTag: View, HTMLTagElementable {
    var element: BlockElement { get }
    init(element: BlockElement)
}


extension BlockTag {
    public var body: some View {
        HTMLBlock(element: element)
    }
}
