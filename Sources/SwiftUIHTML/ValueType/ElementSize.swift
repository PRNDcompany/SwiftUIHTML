//  Copyright © 2025 PRND. All rights reserved.
import Foundation


public struct ElementSize: Sendable, Hashable, Equatable {
    public var width: CGFloat?
    public var height: CGFloat?

    public init(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.width = width
        self.height = height
    }
    
    public init(attributes: [String: AttributeValue]) {
		self.width = attributes["width"]?.cgFloat
		self.height = attributes["height"]?.cgFloat
    }
}
