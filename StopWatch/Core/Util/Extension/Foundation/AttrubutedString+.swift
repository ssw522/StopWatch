//
//  AttrubutedString.swift
//  Receive
//
//  Created by iOS신상우 on 9/17/24.
//


import Foundation
import SwiftUI

extension AttributedString {
    init?(html: String) {
        guard let data = html.data(using: .utf8) else {
            return nil
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(
            data: data,
            options: options,
            documentAttributes: nil
        ) else { return nil }
        
        
        self.init(attributedString)
    }
}
