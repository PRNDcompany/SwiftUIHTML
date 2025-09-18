//  Copyright © 2025 PRND. All rights reserved.
import Foundation


public struct CSSStyle: Sendable {
    private let styles: [String: AttributeValue]

    init(styles: [String: AttributeValue]) {
        self.styles = styles
    }

    public init?(style: String) {
        styles = Dictionary(
            uniqueKeysWithValues: style
                .split(separator: ";")
                .compactMap {
                    let keyValue = $0.split(separator: ":")
                    guard let key = keyValue.first?.trimmingCharacters(in: .whitespaces),
                          let value = keyValue.last?.trimmingCharacters(in: .whitespaces) else { return nil }
                    return (String(key), AttributeValue(rawValue: value))
                }
        )
        
        if styles.isEmpty {
            return nil
        }
    }
    
    public subscript(_ key: String) -> AttributeValue? {
        styles[key]
    }
    
    public func forEach(_ body: ((key: String, value: AttributeValue)) -> Void) {
        styles.forEach(body)
    }
}

extension CSSStyle {
    static let empty = CSSStyle(styles: [:])
}

