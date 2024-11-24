//
//  ColorSystem.swift
//  Receive
//
//  Created by iOS신상우 on 7/23/24.
//

import SwiftUI

public enum ColorToken {
    
    /// static
    case black
    case white
    case clear
    
    /// primary
    case primary_normal
    case primary_alternative
    case primary_fill_normal
    case primary_fill_assistive
    
    /// text
    case text_strong
    case text_normal
    case text_alternative
    case text_assistive
    case text_disable
    
    /// line
    case line_normal
    case line_assistive
    case line_disable
    
    /// fill
    case fill_normal
    case fill_assistive
    case fill_disable
    case fill_disable_assistive
    
    /// background
    case background_primary
    case background_secondary
    
    /// gray
    case gray_text
    case gray_fill_normal
    case gray_alternative
    case gray_assistive
    case gray_fill_assistive
    case gray_fill_off
    
    /// information
    case information_text
    case information_fill_normal
    case information_fill_assistive
    
    /// warning
    case warning_text
    case warning_fill_normal
    case warning_fill_assistive
    
    /// caution
    case caution_normal
    case caution_text_alternative
    case caution_fill_assistive
    
    ///
    case dim
}

public extension ColorToken {
    var color: Color {
        Color.getColor(self)
    }
}
