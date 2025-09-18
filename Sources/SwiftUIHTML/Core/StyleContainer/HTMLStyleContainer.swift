//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


public struct HTMLStyleContainer: Equatable, Sendable, Hashable {
    public func hash(into hasher: inout Hasher) {
        if #available(iOS 16, *) {
            hasher.combine(container)
        } else {
            hasher.combine(HashableAttributeContainer(container))
        }
        hasher.combine(textLine)
    }

    var container = AttributeContainer()

    public var lineBreakMode: LineBreakMode = .byWordWrapping
    
    public var textLine: TextLineAttribute?
    
    public init() { }
    
    public init(container: AttributeContainer) {
        self.container = container
        
    }
    
    func toAttributeContainer() -> AttributeContainer {
        container
    }
}

private struct HashableAttributeContainer: Hashable {
    private let container: AttributeContainer

    init(_ container: AttributeContainer) {
        self.container = container
    }

    func hash(into hasher: inout Hasher) {
        let attributes = container.description
        hasher.combine(attributes)
    }

    static func == (lhs: HashableAttributeContainer, rhs: HashableAttributeContainer) -> Bool {
        return lhs.container.description == rhs.container.description
    }

    var attributeContainer: AttributeContainer {
        return container
    }
}
