//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI
import Foundation


public protocol AttributeStyleable: Sendable {
    associatedtype LayoutModifier: ViewModifier

    func layoutStyle(attributes: [String: AttributeValue]) -> LayoutModifier
    func applyStyles(attributes: [String: AttributeValue], to styleContainer: inout HTMLStyleContainer)
}

