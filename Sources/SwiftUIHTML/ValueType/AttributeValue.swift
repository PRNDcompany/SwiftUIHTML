//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


public struct AttributeValue: Sendable, Hashable {
    let rawValue: String
    
    public func convert<T: RawRepresentable>(to type: T.Type) -> T? where T.RawValue == String {
        type.init(rawValue: rawValue)
    }
    
    public var string: String {
        rawValue
    }
    
    public var cgFloat: CGFloat? {
        if rawValue == "infinity" { return .infinity }
        guard let float else { return nil }
        return CGFloat(float)
    }
    
    public var float: Float? {
        return Float(rawValue.replacingOccurrences(of: "px", with: ""))
    }
    
    public var int: Int? {
        Int(rawValue.replacingOccurrences(of: "px", with: ""))
    }
    
    public var url: URL? {
        URL(string: rawValue)
    }
    
    public var cssStyle: CSSStyle? {
        CSSStyle(style: rawValue)
    }
    
    public func toBool() -> Bool? {
        switch rawValue {
        case "true": return true
        case "false": return false
        case "1": return true
        case "0": return false
        default: return nil
        }
    }
    
    public func toColor() -> Color? {
        Color(cssString: rawValue)
    }
    
    public func toEdgeInsets() -> EdgeInsets? {
        EdgeInsets(cssString: rawValue)
    }
}
