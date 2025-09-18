//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


extension Color {
    /// Initializes a `Color` from a CSS color string.
    /// - Parameter cssString: The CSS color string (e.g., "rgb(255,0,0)", "#RRGGBB", "red").
    init?(cssString: String) {
        let trimmedCSS = cssString.trimmingCharacters(in: .whitespacesAndNewlines)

        // RGB/RGBA 형식 처리
        if trimmedCSS.hasPrefix("rgb") {
            if let color = Color.fromRGBString(trimmedCSS) {
                self = color
                return
            }
        }

        // 16진수 형식 처리
        else if trimmedCSS.hasPrefix("#") {
            if let color = Color.fromHexString(trimmedCSS) {
                self = color
                return
            }
        }

        // 명명된 색상 처리
        else if let color = Color.fromNamedColor(trimmedCSS) {
            self = color
            return
        }

        return nil
    }

    // MARK: - RGB/RGBA 색상 파싱

    /// RGB 또는 RGBA 문자열에서 Color 생성
    private static func fromRGBString(_ rgbString: String) -> Color? {
        let rgbPattern = "rgba?\\((\\d+),\\s*(\\d+),\\s*(\\d+)(?:,\\s*([0-9.]+))?\\)"
        guard let regex = try? NSRegularExpression(pattern: rgbPattern, options: []),
              let match = regex.firstMatch(in: rgbString, options: [], range: NSRange(rgbString.startIndex..<rgbString.endIndex, in: rgbString)) else {
            return nil
        }

        // 컴포넌트 추출
        var components: [Double] = []
        for i in 1..<match.numberOfRanges {
            if let range = Range(match.range(at: i), in: rgbString),
               !rgbString[range].isEmpty {
                if let value = Double(rgbString[range]) {
                    components.append(value)
                } else if i == 4 { // Alpha 값
                    components.append(1.0)
                } else {
                    return nil
                }
            } else if i == 4 { // Alpha 범위가 없는 경우
                components.append(1.0)
            } else {
                return nil
            }
        }

        guard components.count >= 3 else { return nil }

        let r = min(max(components[0] / 255.0, 0), 1)
        let g = min(max(components[1] / 255.0, 0), 1)
        let b = min(max(components[2] / 255.0, 0), 1)
        let a = min(max(components.count >= 4 ? components[3] : 1.0, 0), 1)

        return Color(.sRGB, red: r, green: g, blue: b, opacity: a)
    }

    // MARK: - 16진수 색상 파싱

    /// 16진수 문자열에서 Color 생성
    private static func fromHexString(_ hexString: String) -> Color? {
        // # 제거
        var hex = hexString
        if hex.hasPrefix("#") {
            hex = String(hex.dropFirst())
        }

        // 짧은 형식(RGB, RGBA)을 긴 형식(RRGGBB, RRGGBBAA)으로 변환
        if hex.count == 3 || hex.count == 4 {
            hex = hex.map { String(repeating: $0, count: 2) }.joined()
        }

        // 16진수 문자열 검증
        guard hex.count == 6 || hex.count == 8,
              hex.allSatisfy({ $0.isHexDigit }) else {
            return nil
        }

        // 16진수 값 파싱
        guard let int = UInt64(hex, radix: 16) else {
            return nil
        }

        // 컴포넌트 추출
        let red, green, blue, alpha: Double
        switch hex.count {
        case 6: // RGB (RRGGBB)
            red = Double((int >> 16) & 0xFF) / 255.0
            green = Double((int >> 8) & 0xFF) / 255.0
            blue = Double(int & 0xFF) / 255.0
            alpha = 1.0
        case 8: // RGBA (RRGGBBAA)
            red = Double((int >> 24) & 0xFF) / 255.0
            green = Double((int >> 16) & 0xFF) / 255.0
            blue = Double((int >> 8) & 0xFF) / 255.0
            alpha = Double(int & 0xFF) / 255.0
        default:
            return nil
        }

        return Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    // MARK: - 명명된 색상 파싱

    /// 색상 이름에서 Color 생성
    private static func fromNamedColor(_ colorName: String) -> Color? {
        switch colorName.lowercased() {
        // 기본 색상
        case "black": return .black
        case "white": return .white
        case "red": return .red
        case "green": return .green
        case "blue": return .blue
        case "yellow": return .yellow
        case "orange": return .orange
        case "purple": return .purple
        case "pink": return .pink
        case "gray", "grey": return .gray
        case "brown": return .brown
        case "cyan", "aqua": return .cyan
        case "indigo": return .indigo
        case "mint": return .mint
        case "teal": return .teal

        // 특수 색상
        case "clear", "transparent": return .clear

        // 추가 Web 색상 - 필요에 따라 확장
        case "aliceblue": return Color(red: 0.94, green: 0.97, blue: 1.0)
        case "antiquewhite": return Color(red: 0.98, green: 0.92, blue: 0.84)
        case "aquamarine": return Color(red: 0.5, green: 1.0, blue: 0.83)
        case "azure": return Color(red: 0.94, green: 1.0, blue: 1.0)
        case "beige": return Color(red: 0.96, green: 0.96, blue: 0.86)
        case "bisque": return Color(red: 1.0, green: 0.89, blue: 0.77)
        case "blanchedalmond": return Color(red: 1.0, green: 0.92, blue: 0.8)
        case "blueviolet": return Color(red: 0.54, green: 0.17, blue: 0.89)
        case "burlywood": return Color(red: 0.87, green: 0.72, blue: 0.53)
        case "cadetblue": return Color(red: 0.37, green: 0.62, blue: 0.63)
        case "chocolate": return Color(red: 0.82, green: 0.41, blue: 0.12)
        case "coral": return Color(red: 1.0, green: 0.5, blue: 0.31)
        case "cornflowerblue": return Color(red: 0.39, green: 0.58, blue: 0.93)
        case "cornsilk": return Color(red: 1.0, green: 0.97, blue: 0.86)
        case "crimson": return Color(red: 0.86, green: 0.08, blue: 0.24)
        case "darkblue": return Color(red: 0.0, green: 0.0, blue: 0.55)
        case "darkgray", "darkgrey": return Color(red: 0.66, green: 0.66, blue: 0.66)
        case "darkgreen": return Color(red: 0.0, green: 0.39, blue: 0.0)
        case "darkkhaki": return Color(red: 0.74, green: 0.72, blue: 0.42)
        case "darkred": return Color(red: 0.55, green: 0.0, blue: 0.0)

        // 필요한 경우 더 추가 가능

        default: return nil
        }
    }
}
