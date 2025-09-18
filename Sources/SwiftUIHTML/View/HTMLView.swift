//  Copyright © 2024 PRND. All rights reserved.
import SwiftUI


public struct HTMLView: View, Equatable {
    let html: String

    @HTMLEnvironment(\._configuration) var configuration

    let parser: () -> HTMLParserable

    public init(html: String, parser: @autoclosure @escaping () -> HTMLParserable) {
        self.html = html
        self.parser = parser
    }

    public var body: some View {
        if !html.isEmpty {
            HTMLNodeView(node: parser().parse(html: html))
        }
    }
}

extension HTMLView {
    nonisolated public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.html == rhs.html
    }
}

