//  Copyright © 2025 PRND. All rights reserved.
import Foundation
import CoreText

final class CoreTextRunDelegateManager {
    nonisolated(unsafe) static var shared = CoreTextRunDelegateManager()

    func createDelegate(for attachment: TextAttachment) -> CTRunDelegate? {
        let unmanagedAttachment = Unmanaged.passRetained(attachment)

        var callbacks = CTRunDelegateCallbacks(
            version: kCTRunDelegateVersion1,
            dealloc: { pointer in
                let _ = Unmanaged<TextAttachment>.fromOpaque(pointer).takeRetainedValue()
            },
            getAscent: { pointer -> CGFloat in
                let attachment = Unmanaged<TextAttachment>.fromOpaque(pointer).takeUnretainedValue()
                return attachment.getAdjustedSize().height
            },
            getDescent: { _ in
                return 0
            },
            getWidth: { pointer -> CGFloat in
                let attachment = Unmanaged<TextAttachment>.fromOpaque(pointer).takeUnretainedValue()
                return attachment.bounds.width
            }
        )

        return CTRunDelegateCreate(&callbacks, unmanagedAttachment.toOpaque())
    }
}
