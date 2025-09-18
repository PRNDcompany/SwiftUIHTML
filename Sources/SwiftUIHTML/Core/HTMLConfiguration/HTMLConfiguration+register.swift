//  Copyright © 2025 PRND. All rights reserved.
import Foundation


// MARK: - tag register
public extension HTMLConfiguration {
    func register(tag: String..., renderer: InlineTag.Type) -> Self {
        var copy = self
        tag.forEach {
            copy.dictionary[$0] = renderer
            copy.dictionaryType[$0] = .inline
        }
        return copy
    }

    func register(tag: String..., renderer: any InlineAttachmentTag.Type) -> Self {
        var copy = self
        tag.forEach {
            copy.dictionary[$0] = renderer
            copy.dictionaryType[$0] = .attachment
        }
        return copy
    }

    func register(tag: String..., renderer: any BlockTag.Type) -> Self {
        var copy = self
        tag.forEach {
            copy.dictionary[$0] = renderer
            copy.dictionaryType[$0] = .block
        }
        return copy
    }

    func removeAll() -> Self {
        var copy = self
        copy.dictionary = [:]
        copy.dictionaryType = [:]
        return copy
    }

    func remove(tag: String...) -> Self {
        var copy = self
        tag.forEach {
            copy.dictionary.removeValue(forKey: $0)
            copy.dictionaryType.removeValue(forKey: $0)
        }
        return copy
    }
}
