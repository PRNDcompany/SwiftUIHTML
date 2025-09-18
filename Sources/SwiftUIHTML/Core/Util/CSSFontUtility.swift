//  Copyright © 2025 PRND. All rights reserved.
import UIKit

/// CSS 폰트 스타일 파싱 및 처리를 담당하는 유틸리티 클래스

public enum CSSFontUtility {


    /// CSS font-family 문자열로부터 fallback이 적용된 UIFont 생성
    /// - Parameters:
    ///   - fontFamilyString: CSS font-family 문자열 (예: "Arial, Helvetica, sans-serif")
    ///   - size: 적용할 폰트 크기
    /// - Returns: 생성된 폰트
    static func createFont(fromFontFamily fontFamilyString: String?, size: CGFloat) -> UIFont {
        guard let fontFamilyString = fontFamilyString, !fontFamilyString.isEmpty else {
            return UIFont.systemFont(ofSize: size)
        }

        let fontNames = parseFontFamilyString(fontFamilyString)
        return createFontWithFallbacks(fontNames: fontNames, size: size)
    }

    /// CSS font-size 문자열 파싱하여 CGFloat 값으로 변환
    /// - Parameters:
    ///   - fontSizeString: CSS font-size 문자열 (예: "12px", "1.5em", "large")
    ///   - baseSize: 상대 크기 계산을 위한 기준 크기
    /// - Returns: 파싱된 폰트 크기
    static func parseSize(fromFontSize fontSizeString: String?, baseSize: CGFloat = UIFont.systemFontSize) -> CGFloat {
        guard let fontSizeString = fontSizeString, !fontSizeString.isEmpty else {
            return baseSize
        }

        let trimmed = fontSizeString.trimmingCharacters(in: .whitespacesAndNewlines)

        // 다양한 단위 처리
        if trimmed.hasSuffix("px") {
            if let value = Double(trimmed.dropLast(2)) {
                return CGFloat(value)
            }
        } else if trimmed.hasSuffix("pt") {
            if let value = Double(trimmed.dropLast(2)) {
                return CGFloat(value)
            }
        } else if trimmed.hasSuffix("em") {
            if let value = Double(trimmed.dropLast(2)) {
                return baseSize * CGFloat(value)
            }
        } else if trimmed.hasSuffix("rem") {
            if let value = Double(trimmed.dropLast(3)) {
                return baseSize * CGFloat(value)
            }
        } else if trimmed.hasSuffix("%") {
            if let value = Double(trimmed.dropLast(1)) {
                return baseSize * CGFloat(value / 100)
            }
        } else if let value = Double(trimmed) {
            return CGFloat(value)
        }

        // 키워드 기반 크기
        switch trimmed.lowercased() {
        case "xx-small": return baseSize * 0.6
        case "x-small": return baseSize * 0.75
        case "small": return baseSize * 0.889
        case "medium": return baseSize
        case "large": return baseSize * 1.2
        case "x-large": return baseSize * 1.5
        case "xx-large": return baseSize * 2.0
        case "xxx-large": return baseSize * 3.0
        case "smaller": return baseSize * 0.8
        case "larger": return baseSize * 1.2
        default: return baseSize
        }
    }

    /// CSS 스타일에서 폰트 관련 속성을 추출하여 UIFont 생성
    /// - Parameters:
    ///   - cssStyle: CSS 스타일 딕셔너리
    ///   - currentFont: 현재 설정된 폰트 (기준 크기 및 업데이트용)
    /// - Returns: 생성된 폰트
    static func createFont(fromCSSStyle cssStyle: CSSStyle, currentFont: UIFont? = nil) -> UIFont? {
        let currentSize = currentFont?.pointSize ?? UIFont.systemFontSize

        // font-size와 font-family 속성 추출
        let fontSizeValue = cssStyle["font-size"]?.string
        let fontFamilyValue = cssStyle["font-family"]?.string

        // font 속성이 있다면 해당 속성 파싱 (예: "italic bold 16px/2 Arial, sans-serif")
        if let fontShorthand = cssStyle["font"]?.string {
            let (extractedSize, extractedFamily) = parseFontShorthand(fontShorthand)

            // 개별 속성보다 shorthand 속성이 우선순위가 낮음
            if fontSizeValue == nil, let size = extractedSize {
                let parsedSize = parseSize(fromFontSize: size, baseSize: currentSize)

                if fontFamilyValue == nil, let family = extractedFamily {
                    return createFont(fromFontFamily: family, size: parsedSize)
                } else if let family = fontFamilyValue {
                    return createFont(fromFontFamily: family, size: parsedSize)
                } else {
                    return currentFont?.withSize(parsedSize) ?? UIFont.systemFont(ofSize: parsedSize)
                }
            }
        }

        // font-size 처리
        let size = parseSize(fromFontSize: fontSizeValue, baseSize: currentSize)

        // font-family가 있으면 해당 폰트로, 없으면 현재 폰트의 사이즈만 변경
        if let fontFamily = fontFamilyValue {
            return createFont(fromFontFamily: fontFamily, size: size)
        } else if size != currentSize {
            return currentFont?.withSize(size) ?? UIFont.systemFont(ofSize: size)
        }

        return currentFont
    }

    // MARK: - Private Helper Methods

    private static func parseFontFamilyString(_ fontFamilyString: String) -> [String] {
        return fontFamilyString
            .components(separatedBy: ",")
            .map {
                $0.trimmingCharacters(in: .whitespacesAndNewlines)
                  .replacingOccurrences(of: "\"", with: "")
                  .replacingOccurrences(of: "'", with: "")
            }
            .filter { !$0.isEmpty }
    }

    private static func createFontWithFallbacks(fontNames: [String], size: CGFloat) -> UIFont {
        // 특정 폰트 이름과 제네릭 패밀리 분리
        var specificFontNames: [String] = []
        var genericFamily: String? = nil

        for name in fontNames {
            if isGenericFontFamily(name) {
                genericFamily = name
            } else {
                specificFontNames.append(name)
            }
        }

        // 첫 번째 유효한 폰트 찾기
        var primaryFont: UIFont! = nil
        for name in specificFontNames {
            if let font = UIFont(name: name, size: size) {
                primaryFont = font
                break
            }
        }

        // 유효한 폰트가 없으면 제네릭이나 시스템 폰트 사용
        if primaryFont == nil {
            if let genericFamily = genericFamily {
                return createSystemFontForGenericFamily(genericFamily, size: size)
            }
            return UIFont.systemFont(ofSize: size)
        }

        // 기본 폰트의 descriptor 가져오기
        let primaryDescriptor = primaryFont!.fontDescriptor

        // Cascade 목록 생성
        var cascadeList: [UIFontDescriptor] = []

        // Fallback 폰트 추가 (첫 번째 이후의 특정 폰트들)
        if specificFontNames.count > 1 {
            for name in specificFontNames.dropFirst() {
                if let font = UIFont(name: name, size: size) {
                    cascadeList.append(font.fontDescriptor)
                }
            }
        }

        // 제네릭 폰트 추가
        if let genericFamily = genericFamily {
            let genericFont = createSystemFontForGenericFamily(genericFamily, size: size)
            cascadeList.append(genericFont.fontDescriptor)
        }

        // 최종 fallback으로 시스템 폰트 추가
        cascadeList.append(UIFont.systemFont(ofSize: size).fontDescriptor)

        // cascade 목록이 비어있지 않으면 descriptor 업데이트
        if !cascadeList.isEmpty {
            let descriptorWithCascade = primaryDescriptor.addingAttributes([
                UIFontDescriptor.AttributeName.cascadeList: cascadeList
            ])
            return UIFont(descriptor: descriptorWithCascade, size: 0) // 0은 원래 크기 유지
        }

        return primaryFont
    }

    private static func isGenericFontFamily(_ name: String) -> Bool {
        let genericFamilies = ["serif", "sans-serif", "monospace", "cursive", "fantasy", "system-ui"]
        return genericFamilies.contains(name.lowercased())
    }

    private static func createSystemFontForGenericFamily(_ family: String, size: CGFloat) -> UIFont {
        switch family.lowercased() {
        case "serif":
            return UIFont(name: "TimesNewRomanPSMT", size: size) ?? UIFont.systemFont(ofSize: size)
        case "sans-serif":
            return UIFont.systemFont(ofSize: size)
        case "monospace":
            if #available(iOS 13.0, *) {
                return UIFont.monospacedSystemFont(ofSize: size, weight: .regular)
            } else {
                return UIFont(name: "Menlo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
            }
        case "cursive":
            return UIFont(name: "SnellRoundhand", size: size) ?? UIFont.systemFont(ofSize: size)
        case "fantasy":
            return UIFont(name: "Papyrus", size: size) ?? UIFont.systemFont(ofSize: size)
        case "system-ui":
            return UIFont.systemFont(ofSize: size)
        default:
            return UIFont.systemFont(ofSize: size)
        }
    }

    private static func parseFontShorthand(_ fontString: String) -> (size: String?, family: String?) {
        // font: [font-style] [font-variant] [font-weight] [font-size/line-height] [font-family]
        // 예: "italic bold 16px/2 Arial, sans-serif"

        let components = fontString.components(separatedBy: .whitespaces)

        // 마지막 요소가 폰트 패밀리 (쉼표로 구분된 목록일 수 있음)
        var familyStartIndex = -1
        for (index, component) in components.enumerated().reversed() {
            if component.contains(",") || isGenericFontFamily(component) {
                familyStartIndex = index
                break
            }
        }

        // 폰트 패밀리 조합
        var fontFamily: String? = nil
        if familyStartIndex >= 0 {
            fontFamily = components[familyStartIndex...].joined(separator: " ")
        }

        // 폰트 사이즈 찾기 (px, pt, em, rem, % 등으로 끝나는 요소)
        var fontSize: String? = nil
        for component in components {
            if component.hasSuffix("px") || component.hasSuffix("pt") ||
               component.hasSuffix("em") || component.hasSuffix("rem") ||
               component.hasSuffix("%") ||
               ["xx-small", "x-small", "small", "medium", "large", "x-large", "xx-large", "xxx-large", "smaller", "larger"].contains(component.lowercased()) {
                fontSize = component.split(separator: "/").first.map(String.init) // line-height 제거
                break
            }
        }

        return (fontSize, fontFamily)
    }
}
