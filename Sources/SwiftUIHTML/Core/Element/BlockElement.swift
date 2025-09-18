//  Copyright © 2024 PRND. All rights reserved.
import Foundation


@MainActor
public struct BlockElement: Sendable, Hashable {
    public let tag: String
    public let attributes: [String: AttributeValue]
    public let contents: [TagElement]
    public let styleContainer: HTMLStyleContainer
}
