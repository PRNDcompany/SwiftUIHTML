//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI

import SwiftUIHTML


struct ULTagView: BlockTag {
    let element: BlockElement

    @HTMLEnvironment(\.listIndentCount) var indentCount

    init(element: BlockElement) {
        self.element = element
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ForEach(lilist(element: element), id: \.0) { _, element in
                liTag(liElement: element)
            }
        }
        .padding(.leading, indent(indentCount))
        .htmlEnvironment(\.listIndentCount, indentCount + 1)
    }

    func liTag(liElement: BlockElement) -> some View {
        HStack(alignment: .top, spacing: .zero) {
            HTMLText(" • ")
            VStack(alignment: .leading, spacing: 4) {
                HTMLBlock(element: liElement)
            }
        }
    }

    func indent(_ index: Int) -> CGFloat {
        if index == .zero { return .zero }
        return 16
    }

    func lilist(element: BlockElement) -> [(Int, BlockElement)] {
        let result: [BlockElement] = element.contents
            .compactMap {
                guard case .block(let element) = $0 else { return nil }
                return element
            }
        return Array(zip(result.indices, result))
    }
}


private struct ListIndentCountKey: HTMLEnvironmentKey {
    static let defaultValue: Int = 0
}

extension HTMLEnvironmentValues {
    var listIndentCount: Int {
        get { self[ListIndentCountKey.self] }
        set { self[ListIndentCountKey.self] = newValue }
    }
}
