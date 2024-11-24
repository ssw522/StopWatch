//
//  Typography.swift
//  Receive
//
//  Created by iOS신상우 on 7/24/24.
//

import SwiftUI

public enum Typography {
    /// title
    case title1
    case title2
    case title3
    case title4
    case title5
    
    
    /// subtitle
    case subTitle1
    case subTitle2
    case subTitle3
    
    
    /// label
    case label1
    case label2
    case label3
    case label4
    
    
    /// body
    case body1
    case body2
    
    
    /// caption
    case caption1
    case caption2
    case caption3
    
    
    /// input
    case input1
    case input2
}

extension Typography {
    
    /// SwiftUI Font
    var font: Font {
        Font(self.uiFont)
    }
    
    
    /// UIKit UIFont
    var uiFont: UIFont {
        switch self {
        case .title1:
            return .pretendard(size: 28, weight: .bold)
        case .title2:
            return .pretendard(size: 24, weight: .bold)
        case .title3:
            return .pretendard(size: 20, weight: .bold)
        case .title4:
            return .pretendard(size: 18, weight: .bold)
        case .title5:
            return .pretendard(size: 16, weight: .bold)
        case .subTitle1:
            return .pretendard(size: 24, weight: .semibold)
        case .subTitle2:
            return .pretendard(size: 20, weight: .semibold)
        case .subTitle3:
            return .pretendard(size: 18, weight: .semibold)
        case .label1:
            return .pretendard(size: 16, weight: .semibold)
        case .label2:
            return .pretendard(size: 14, weight: .semibold)
        case .label3:
            return .pretendard(size: 12, weight: .semibold)
        case .label4:
            return .pretendard(size: 11, weight: .semibold)
        case .body1:
            return .pretendard(size: 16, weight: .regular)
        case .body2:
            return .pretendard(size: 14, weight: .regular)
        case .caption1:
            return .pretendard(size: 12, weight: .regular)
        case .caption2:
            return .pretendard(size: 11, weight: .regular)
        case .caption3:
            return .pretendard(size: 10, weight: .regular)
        case .input1:
            return .pretendard(size: 16, weight: .regular)
        case .input2:
            return .pretendard(size: 14, weight: .semibold)
        }
    }
    
    var lineHeight: CGFloat {
        switch self {
            /// title
        case .title1: 38
        case .title2: 32
        case .title3: 28
        case .title4: 26
        case .title5: 24
            
            /// subTitle
        case .subTitle1: 32
        case .subTitle2: 28
        case .subTitle3: 26
            
            /// label
        case .label1: 24
        case .label2: 20
        case .label3: 18
        case .label4: 16
            
            /// body
        case .body1: 24
        case .body2: 20
            
            /// caption
        case .caption1: 18
        case .caption2: 16
        case .caption3: 14
            
            /// input
        case .input1: 20
        case .input2: 18
        }
    }
}

// MARK: - 실제 typo 사용
public extension View {
    
    /**
     Font 및 lineHeight 적용
     ````swift
     Text("Typo example")
        .setTypo(.title1)
     ````
     */
    func setTypo(_ typo: Typography) -> some View {
        self
            .font(typo.font)
            .modifier(LineHeightModifier(font: typo.uiFont, lineHeight: typo.lineHeight))
    }
}
