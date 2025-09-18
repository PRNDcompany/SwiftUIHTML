//  Copyright © 2025 PRND. All rights reserved.
import CoreFoundation


extension CGSize {
    static let invisible = CGSize(width: 0.1, height: 0.1)

    static func >(lhs: CGSize, rhs: CGSize) -> Bool {
        lhs.width * lhs.height > rhs.width * rhs.height
    }
}
