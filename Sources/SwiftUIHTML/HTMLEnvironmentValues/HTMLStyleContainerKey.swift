//  Copyright © 2024 PRND. All rights reserved.
import Foundation

private struct HTMLStyleContainerKey: HTMLEnvironmentKey {
    static var defaultValue: HTMLStyleContainer { HTMLStyleContainer() }
}

extension HTMLEnvironmentValues {
    public var styleContainer: HTMLStyleContainer {
        get { self[HTMLStyleContainerKey.self] }
        set { self[HTMLStyleContainerKey.self] = newValue }
    }
}
