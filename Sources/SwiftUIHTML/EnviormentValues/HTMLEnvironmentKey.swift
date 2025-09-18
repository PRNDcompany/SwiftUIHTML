//  Copyright © 2024 PRND. All rights reserved.
import Foundation

public protocol HTMLEnvironmentKey {
    associatedtype Value
    static var defaultValue: Self.Value { get }
}
