//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


public protocol HTMLTagElementable {
    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer)
}


public extension HTMLTagElementable {
    static func applyStyles(with attributes: [String : AttributeValue], to styleContainer: inout HTMLStyleContainer) {
        
    }
}
