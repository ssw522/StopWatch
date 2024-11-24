//
//  UIColor+ColorToken.swift
//  Receive
//
//  Created by iOS신상우 on 7/23/24.
//

import UIKit.UIColor

public extension UIColor {
    static func getColor(_ color: ColorToken) -> UIColor {
        switch color {
            
            /// static
        case .black:
            return .black
        case .white:
            return .white
            
            /// primary
        case .primary_normal:
            return .init(resource: .primary50)
        case .primary_alternative:
            return .init(resource: .primary40)
        case .primary_fill_normal:
            return .init(resource: .primary5)
        case .primary_fill_assistive:
            return .init(resource: .primary2)
            
            /// text
        case .text_strong:
            return .black
        case .text_normal:
            return .init(resource: .netural90)
        case .text_alternative:
            return .init(resource: .netural60)
        case .text_assistive:
            return .init(resource: .netural40)
        case .text_disable:
            return .init(resource: .netural30)
            
            /// line
        case .line_normal:
            return .init(resource: .coolGray15)
        case .line_assistive:
            return .init(resource: .coolGray10)
        case .line_disable:
            return .init(resource: .netural15)
            
            /// fill
        case .fill_normal:
            return .init(resource: .coolGray10)
        case .fill_assistive:
            return .init(resource: .coolGray5)
        case .fill_disable:
            return .init(resource: .netural10)
        case .fill_disable_assistive:
            return .init(resource: .netural5)
            
            /// background
        case .background_primary:
            return .init(resource: .coolGray2)
        case .background_secondary:
            return .white
            
            /// gray
        case .gray_text:
            return .init(resource: .coolGray90)
        case .gray_fill_normal:
            return .init(resource: .coolGray80)
        case .gray_alternative:
            return .init(resource: .coolGray60)
        case .gray_assistive:
            return .init(resource: .coolGray30)
        case .gray_fill_assistive:
            return .init(resource: .coolGray30)
        case .gray_fill_off:
            return .init(resource: .coolGray25)
            
            /// information
        case .information_text:
            return .init(resource: .information60)
        case .information_fill_normal:
            return .init(resource: .information50)
        case .information_fill_assistive:
            return .init(resource: .information5)
            
            /// warning
        case .warning_text:
            return .init(resource: .warning70)
        case .warning_fill_normal:
            return .init(resource: .warning50)
        case .warning_fill_assistive:
            return .init(resource: .warning5)
            
            /// caution
        case .caution_normal:
            return .init(resource: .caution50)
        case .caution_text_alternative:
            return .init(resource: .caution40)
        case .caution_fill_assistive:
            return .init(resource: .caution5)
            
            /// opacity
        case .dim:
            return .init(resource: .opacity3N2)
            
            /// other
        case .clear:
            return .clear
        }
    }
}

/// 나중에 패키지로 뺀다면 사용
public extension UIColor {
//    convenience init?(name: String) {
//        self.init(named: name, in: Bundle.module, compatibleWith: nil)
//    }
}
