// Copyright © 2025 PRND. All rights reserved.
import SwiftUI


public struct HTMLNodeView: View {
    private let node: HTMLNode
    
    @HTMLEnvironment(\._configuration) var configuration
    @HTMLEnvironment(\.styleContainer) var styleContainer

    public init(node: HTMLNode) {
        self.node = node
    }
    
    public var body: some View {
        HTMLBlock(
            element: node.toElement(
                configuration: configuration,
                with: styleContainer
            )
        )
    }
}

extension HTMLNodeView: @preconcurrency Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.node == rhs.node
    }
}
