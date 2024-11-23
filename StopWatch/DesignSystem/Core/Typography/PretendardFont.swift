//
//  PretendardFont.swift
//  Receive
//
//  Created by iOS신상우 on 7/24/24.
//

import SwiftUI


// MARK: - SwiftUI
public extension Font {
    
    /// Pretenard
    static func pretendard(size: CGFloat, weight: FontWeight) -> Font {
        return Font.custom("Pretendard-\(weight.rawValue)", size: size)
    }
}


// MARK: - UIKit

public extension UIFont {
    
    /// Pretenard
    static func pretendard(size: CGFloat, weight: FontWeight) -> UIFont {
        return UIFont(name: "Pretendard-\(weight.rawValue)", size: size) ?? .systemFont(ofSize: size)
    }
}
