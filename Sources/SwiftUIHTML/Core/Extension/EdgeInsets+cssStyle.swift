//  Copyright © 2025 PRND. All rights reserved.
import SwiftUI


extension EdgeInsets {
    init?(cssString: String) {
        let components = cssString.components(separatedBy: " ")
            .compactMap { component -> CGFloat? in
                // px, em, rem 등의 단위 처리
                let valueStr = component.replacingOccurrences(of: "px", with: "")
                    .replacingOccurrences(of: "em", with: "")
                    .replacingOccurrences(of: "rem", with: "")
                return CGFloat(Double(valueStr) ?? 0)
            }
        
        switch components.count {
        case 1: // 모든 방향에 동일한 값 (margin: 10px)
            self.init(top: components[0], leading: components[0], bottom: components[0], trailing: components[0])
        case 2: // 상하/좌우 값 (margin: 10px 20px)
            self.init(top: components[0], leading: components[1], bottom: components[0], trailing: components[1])
        case 3: // 상/좌우/하 값 (margin: 10px 20px 30px)
            self.init(top: components[0], leading: components[1], bottom: components[2], trailing: components[1])
        case 4: // 상/우/하/좌 값 (margin: 10px 20px 30px 40px)
            self.init(top: components[0], leading: components[3], bottom: components[2], trailing: components[1])
        default:
            return nil
        }
    }
}
