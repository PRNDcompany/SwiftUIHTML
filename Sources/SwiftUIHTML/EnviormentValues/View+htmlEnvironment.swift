//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


extension View {
    public func htmlEnvironment<V>(
        _ keyPath: WritableKeyPath<HTMLEnvironmentValues, V>,
        _ value: V
    ) -> some View {
        modifier(HTMLUpdateModifier(keyPath: keyPath, value: value))
    }
}

fileprivate struct HTMLUpdateModifier<V>: ViewModifier {
    @Environment(\.htmlContainer) var container

    let keyPath: WritableKeyPath<HTMLEnvironmentValues, V>
    let value: V

    func body(content: Content) -> some View {
        content
            .environment(\.htmlContainer, {
                var copy = container
                copy[keyPath: keyPath] = value
                return copy
            }())
    }
}
