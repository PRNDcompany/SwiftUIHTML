//  Copyright © 2025 PRND. All rights reserved.
import Foundation

final class Weak<T: AnyObject> {
    var value: T?
    init(value: T? = nil) {
        self.value = value
    }
}
