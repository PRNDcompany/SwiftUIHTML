//  Copyright © 2024 PRND. All rights reserved.
import Foundation


public enum LineBreakMode: Sendable {
    case byCharWrapping
    case byWordWrapping
    case custom(id: String, transform: @Sendable (String) -> String)
}


extension LineBreakMode {
    func callAsFunction(_ text: String) -> String {
        switch self {
        case .byCharWrapping:
            return text.byCharWrapping()
        case .byWordWrapping:
            return text
        case .custom(let id, let transform):
            return transform(text)
        }
    }
}

extension LineBreakMode: Equatable, CustomStringConvertible {
    public static func == (lhs: LineBreakMode, rhs: LineBreakMode) -> Bool {
        switch (lhs, rhs) {
        case (.byCharWrapping, .byCharWrapping): return true
        case (.byWordWrapping, .byWordWrapping): return true
        case let (.custom(lid, _), .custom(rid, _)): return lid == rid
        default: return false
        }
    }

    public var description: String {
        switch self {
        case .byCharWrapping: return "byCharWrapping"
        case .byWordWrapping: return "byWordWrapping"
        case .custom(let id, _): return id
        }
    }
}
