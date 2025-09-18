//  Copyright © 2025 PRND. All rights reserved.
import Foundation


struct HTMLConfigurationKey: HTMLEnvironmentKey {
    static var defaultValue: HTMLConfiguration? { nil }
}

extension HTMLEnvironmentValues {
    public var configuration: HTMLConfiguration? {
        get { self[HTMLConfigurationKey.self] }
        set { self[HTMLConfigurationKey.self] = newValue }
    }
    
    var _configuration: HTMLConfiguration {
        configuration ?? .default
    }
}
