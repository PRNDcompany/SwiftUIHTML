//  Copyright © 2025 PRND. All rights reserved.
import Foundation
import CoreText
import UIKit

/// Calculates frame rectangles for text ranges using Core Text
final class TextRangeFrameCalculator {

    // MARK: - Properties

    /// Additional spacing between lines
    var lineSpacing: CGFloat = 0

    // MARK: - Public Methods

    /// Finds attributes and their ranges in an attributed string
    /// - Parameters:
    ///   - attributedString: The string to search in
    ///   - key: The attribute key to search for
    ///   - type: The expected type of the attribute
    /// - Returns: Array of tuples containing the attribute value and its range
    func findAttribute<T>(
        in attributedString: NSAttributedString,
        for key: NSAttributedString.Key,
        type: T.Type
    ) -> [(value: T, range: NSRange)] {
        var targets: [(T, NSRange)] = []
        let fullRange = NSRange(location: 0, length: attributedString.length)

        attributedString.enumerateAttribute(key, in: fullRange) { value, range, _ in
            guard let target = value as? T else { return }
            targets.append((target, range))
        }
        return targets
    }

    /// Finds ranges where a specific attribute is present
    /// - Parameters:
    ///   - attributedString: The string to search in
    ///   - key: The attribute key to search for
    /// - Returns: Array of ranges where the attribute exists
    func findRanges(
        in attributedString: NSAttributedString,
        for key: NSAttributedString.Key
    ) -> [NSRange] {
        var ranges: [NSRange] = []
        let fullRange = NSRange(location: 0, length: attributedString.length)

        attributedString.enumerateAttribute(key, in: fullRange) { value, range, _ in
            if value != nil {
                ranges.append(range)
            }
        }
        return ranges
    }

    /// Prepares an attributed string for Core Text by converting attachments to run delegates
    /// - Parameter attributedString: The attributed string to prepare
    /// - Returns: A mutable attributed string prepared for Core Text
    func prepareCoreTextString(_ attributedString: NSAttributedString) -> NSMutableAttributedString {
        let mutableAttrString = NSMutableAttributedString(attributedString: attributedString)

        let fullRange = NSRange(location: 0, length: mutableAttrString.length)
        mutableAttrString.enumerateAttribute(.attachment, in: fullRange) { value, range, _ in
            guard let attachment = value as? TextAttachment else { return }
            if let delegate = CoreTextRunDelegateManager.shared.createDelegate(for: attachment) {
                mutableAttrString.removeAttribute(.attachment, range: range)
                mutableAttrString.addAttribute(.runDelegate, value: delegate, range: range)
            }
        }

        return mutableAttrString
    }

    /// Main interface: Measures layout for specified text ranges
    /// - Parameters:
    ///   - preparedString: The prepared attributed string
    ///   - containerSize: The size of the container
    ///   - ranges: Text ranges to measure
    /// - Returns: Array of rectangles for each range
    func measureLayout(
        for preparedString: NSMutableAttributedString,
        in containerSize: CGSize,
        by ranges: [NSRange]
    ) -> [CGRect] {
        return calculateTextFrames(
            attributedString: preparedString,
            containerSize: containerSize,
            targetRanges: ranges
        )
    }
}

// MARK: - Private Methods

private extension TextRangeFrameCalculator {

    /// Calculates layout frames for target ranges
    /// - Parameters:
    ///   - attributedString: The prepared attributed string
    ///   - containerSize: The container size
    ///   - targetRanges: Text ranges to measure
    /// - Returns: Array of rectangles for each range
    func calculateTextFrames(
        attributedString: NSAttributedString,
        containerSize: CGSize,
        targetRanges: [NSRange]
    ) -> [CGRect] {
        let frame = createTextFrame(for: attributedString, containerSize: containerSize)
        return calculateRangeRects(in: frame, containerSize: containerSize, targetRanges: targetRanges)
    }

    /// Creates a Core Text frame for the attributed string
    /// - Parameters:
    ///   - attrString: The attributed string
    ///   - containerSize: Size of the container
    /// - Returns: A Core Text frame
    func createTextFrame(for attrString: NSAttributedString, containerSize: CGSize) -> CTFrame {
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)

        // Calculate optimal text size with constraints
        let suggestedSize = CTFramesetterSuggestFrameSizeWithConstraints(
            framesetter,
            CFRange(),
            nil,
            CGSize(width: containerSize.width, height: .greatestFiniteMagnitude),
            nil
        )

        // Ensure minimum dimensions
        let width = max(suggestedSize.width, containerSize.width)
        let height = max(suggestedSize.height, containerSize.height)

        let rect = CGRect(origin: .zero, size: CGSize(width: width, height: suggestedSize.height))
        let path = CGPath(rect: rect, transform: nil)

        return CTFramesetterCreateFrame(framesetter, CFRange(), path, nil)
    }

    /// Calculates line metrics for text lines
    /// - Parameter lines: Array of Core Text lines
    /// - Returns: Array of line metrics (ascent, descent, leading)
    func calculateLineMetrics(for lines: [CTLine]) -> [(ascent: CGFloat, descent: CGFloat, leading: CGFloat)] {
        return lines.map { line in
            var ascent: CGFloat = 0
            var descent: CGFloat = 0
            var leading: CGFloat = 0
            _ = CTLineGetTypographicBounds(line, &ascent, &descent, &leading)
            return (ascent, descent, leading)
        }
    }

    /// Gets original line origins from Core Text frame
    /// - Parameters:
    ///   - frame: The Core Text frame
    ///   - count: Number of lines
    /// - Returns: Array of line origin points
    func getOriginalLineOrigins(frame: CTFrame, count: Int) -> [CGPoint] {
        var origins = Array(repeating: CGPoint.zero, count: count)
        CTFrameGetLineOrigins(frame, CFRange(), &origins)
        return origins
    }

    /// Adjusts line origins to account for line spacing
    /// - Parameters:
    ///   - frame: The Core Text frame
    ///   - lines: Array of Core Text lines
    ///   - containerSize: Size of the container
    /// - Returns: Array of adjusted line origin points
    func adjustLineOrigins(frame: CTFrame, lines: [CTLine], containerSize: CGSize) -> [CGPoint] {
        guard !lines.isEmpty else { return [] }

        // Get original origins and line metrics
        let origins = getOriginalLineOrigins(frame: frame, count: lines.count)
        let lineMetrics = calculateLineMetrics(for: lines)

        var adjustedOrigins = [CGPoint](repeating: .zero, count: lines.count)

        // Position first line
        let firstAscent = lineMetrics[0].ascent
        adjustedOrigins[0] = CGPoint(x: origins[0].x, y: firstAscent)

        // Position remaining lines
        for i in 1..<lines.count {
            let prevPosition = adjustedOrigins[i-1].y
            let prevMetrics = lineMetrics[i-1]
            let currentAscent = lineMetrics[i].ascent

            // Calculate vertical position with line spacing
            let y = prevPosition + prevMetrics.descent + prevMetrics.leading + currentAscent + lineSpacing
            adjustedOrigins[i] = CGPoint(x: origins[i].x, y: y)
        }

        return adjustedOrigins
    }

    /// Calculates rectangles for target text ranges
    /// - Parameters:
    ///   - frame: The Core Text frame
    ///   - containerSize: Size of the container
    ///   - targetRanges: Text ranges to measure
    /// - Returns: Array of rectangles for each range
    func calculateRangeRects(in frame: CTFrame, containerSize: CGSize, targetRanges: [NSRange]) -> [CGRect] {
        let lines = CTFrameGetLines(frame) as! [CTLine]
        let adjustedOrigins = adjustLineOrigins(frame: frame, lines: lines, containerSize: containerSize)

        var rangeRects: [CGRect] = []

        // Process each line
        for (lineIndex, line) in lines.enumerated() {
            let lineRange = CTLineGetStringRange(line)
            let lineNSRange = NSRange(location: lineRange.location, length: lineRange.length)

            // Find ranges that intersect with this line
            let intersectingRanges = targetRanges.filter { range in
                NSIntersectionRange(lineNSRange, range).length > 0
            }

            guard !intersectingRanges.isEmpty else { continue }

            let lineOrigin = adjustedOrigins[lineIndex]
            let characterRects = calculateCharacterBounds(in: line, ranges: intersectingRanges)

            // Get line metrics
            var ascent: CGFloat = 0
            var descent: CGFloat = 0
            _ = CTLineGetTypographicBounds(line, &ascent, &descent, nil)

            // Create rect for each character range
            for charFrame in characterRects {
                let lineRect = CGRect(
                    x: charFrame.origin.x,
                    y: lineOrigin.y,
                    width: charFrame.size.width,
                    height: charFrame.size.height
                )
                rangeRects.append(lineRect)
            }
        }

        return rangeRects
    }

    /// Calculates bounds for text ranges within a line
    /// - Parameters:
    ///   - line: The Core Text line
    ///   - ranges: Text ranges to measure
    /// - Returns: Array of rectangles for the ranges in this line
    func calculateCharacterBounds(in line: CTLine, ranges: [NSRange]) -> [CGRect] {
        var characterBounds: [CGRect] = []

        let lineRange = CTLineGetStringRange(line)
        let lineNSRange = NSRange(location: lineRange.location, length: lineRange.length)

        // Calculate metrics for the line
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        _ = CTLineGetTypographicBounds(line, &ascent, &descent, nil)

        // Process each range
        for range in ranges {
            // Check if the range intersects with this line
            let intersection = NSIntersectionRange(lineNSRange, range)
            guard intersection.length > 0 else { continue }

            // Calculate offsets for the intersection range
            var secondaryOffset: CGFloat = 0
            let startOffset = CTLineGetOffsetForStringIndex(line, intersection.location, &secondaryOffset)
            let endOffset = CTLineGetOffsetForStringIndex(line, intersection.location + intersection.length, &secondaryOffset)

            // Create rectangle for the range
            let width = endOffset - startOffset
            let rect = CGRect(
                x: startOffset,
                y: -descent,
                width: width,
                height: ascent + descent
            )
            characterBounds.append(rect)
        }

        return characterBounds
    }
}

// MARK: - Extensions

extension NSAttributedString.Key {
    static let runDelegate = NSAttributedString.Key(kCTRunDelegateAttributeName as String)
}
