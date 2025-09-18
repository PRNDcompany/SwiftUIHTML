//  Copyright © 2025 PRND. All rights reserved.
import Foundation

/// Class that provides HTML document compression functionality
public enum HTMLMinifier {
    /// Removes unnecessary whitespace from HTML documents and optimizes them.
    /// - Parameter html: Original HTML string
    /// - Returns: Optimized HTML string
    public static func minify(_ html: String) -> String {
        guard html.count > 3 else { return html }
        // 1. Remove whitespace and line breaks after <br> tags
        var result = html.replacingOccurrences(of: "<br\\s*/?>[\\s\\n\\r]+", with: "<br>", options: .regularExpression)

        // 2. Remove whitespace with line breaks between regular tags
        result = result.replacingOccurrences(of: ">\\s*[\\n\\r]\\s*<", with: "><", options: .regularExpression)

        // 3. Convert only pure whitespace between tags to &nbsp; (when no line breaks)
        let pattern = ">([\\s]+)<"

        while let range = result.range(of: pattern, options: .regularExpression) {
            let spacesRange = result.index(after: range.lowerBound)..<result.index(before: range.upperBound)
            let spaces = result[spacesRange]

            // Replace with &nbsp; only when whitespace has no line breaks
            let nbspString = String(repeating: "&nbsp;", count: spaces.count)
            result.replaceSubrange(range, with: ">" + nbspString + "<")
        }

        // 4. Remove all remaining line breaks and tabs (excluding inside tags)
        result = result.replacingOccurrences(of: ">([^<]*?)[\\n\\r\\t]+([^<]*?)<", with: ">$1 $2<", options: .regularExpression)

        return result
    }


}
