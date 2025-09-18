// Copyright © 2025 PRND. All rights reserved.
import SwiftUI


public protocol InlineAttachmentTag: View, HTMLTagElementable {
    var attributes: [String: AttributeValue] { get }
    init(attributes: [String: AttributeValue])
}
