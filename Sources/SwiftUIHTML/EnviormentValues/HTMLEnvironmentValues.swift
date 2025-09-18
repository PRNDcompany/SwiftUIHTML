//  Copyright © 2024 PRND. All rights reserved.
import Foundation


public struct HTMLEnvironmentValues {
    var storage: [ObjectIdentifier: Any] = [:]
    public subscript<Key: HTMLEnvironmentKey>(key: Key.Type) -> Key.Value {
        get { storage[ObjectIdentifier(key)] as? Key.Value ?? Key.defaultValue }
        set { storage[ObjectIdentifier(key)] = newValue }
    }
}
