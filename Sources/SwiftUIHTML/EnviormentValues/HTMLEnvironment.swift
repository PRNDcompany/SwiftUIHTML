//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI

@propertyWrapper
public struct HTMLEnvironment<Value>: DynamicProperty {
    let environment: Environment<HTMLEnvironmentValues>
    let keyPath: KeyPath<HTMLEnvironmentValues, Value>

    public var wrappedValue: Value {
        environment.wrappedValue[keyPath: keyPath]
    }

    public init(_ keyPath: KeyPath<HTMLEnvironmentValues, Value>) {
        self.environment = .init(\.htmlContainer)
        self.keyPath = keyPath
    }
}

// MARK: Internal
extension EnvironmentValues {
    var htmlContainer: HTMLEnvironmentValues {
        get { self[HTMLEnvironmentEnvironmentKey.self] }
        set { self[HTMLEnvironmentEnvironmentKey.self] = newValue }
    }
}

private struct HTMLEnvironmentEnvironmentKey: EnvironmentKey {
    static var defaultValue: HTMLEnvironmentValues {
        HTMLEnvironmentValues()
    }
}
