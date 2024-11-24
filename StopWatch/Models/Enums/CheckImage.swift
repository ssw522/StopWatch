//
//  CheckImage.swift
//  StopWatch
//
//  Created by 신상우 on 2023/05/29.
//

import UIKit

enum CheckImage: Int {
    case null
    case circle
    case triangle
    case xmark
    
    var image: UIImage {
        switch self {
        case .null: return UIImage()
        case .circle: return UIImage(systemName: "circle") ?? UIImage()
        case .triangle: return UIImage(systemName: "triangle") ?? UIImage()
        case .xmark: return UIImage(systemName: "xmark") ?? UIImage()
        }
    }
    
    var title: String {
        switch self {
        case .null: return ""
        case .circle: return "Done"
        case .triangle: return "In Progress"
        case .xmark: return "UnDone"
        }
    }
}
