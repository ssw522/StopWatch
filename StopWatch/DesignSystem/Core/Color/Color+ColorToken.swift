//
//  Color+ColorToken.swift
//  Receive
//
//  Created by iOS신상우 on 7/23/24.
//

import SwiftUI

public extension Color {
    static func getColor(_ color: ColorToken) -> Color {
        .init(uiColor: .getColor(color))
    }
    
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    init?(hex: String, opacity: Double = 1.0) {
        let filteredHex = hex.replacingOccurrences(of: "0x", with: "")
        
        if let hex: Int = Int(filteredHex, radix: 16) {
            self.init(hex: hex, opacity: opacity)
        } else {
            return nil
        }
    }
}
