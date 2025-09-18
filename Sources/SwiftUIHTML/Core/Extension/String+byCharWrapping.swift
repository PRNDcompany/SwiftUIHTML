//  Copyright © 2024 PRND. All rights reserved.
import Foundation


extension String {
    func byCharWrapping() -> String {
        let pattern = "([\\p{L}\\p{N}])(?=[\\p{L}\\p{N}])"
        return replacingOccurrences(
            of: pattern,
            with: "$1\u{200B}",
            options: .regularExpression
        )
    }
}
