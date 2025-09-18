//  Copyright © 2024 PRND. All rights reserved.
import Foundation


public protocol HTMLParserable {
    func parse(html: String) -> HTMLNode
}
