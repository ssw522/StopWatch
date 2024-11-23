//
//  TabItem.swift
//  Receive
//
//  Created by iOS신상우 on 7/29/24.
//

import SwiftUI

enum TabItem: CaseIterable {
    case todo
    case stopWatch
    case chart
    case setting
    
    var title: String {
        switch self {
        case .todo:
            return "투두"
        case .stopWatch:
            return "스톱워치"
        case .chart:
            return "통계"
        case .setting:
            return "설정"
        }
    }
    
    var tabIcon: Image {
        switch self {
        case .todo:
            return .init(systemName: "highlighter")
        case .stopWatch:
            return .init(systemName: "gauge.with.needle")
        case .chart:
            return .init(systemName: "chart.pie.fill")
        case .setting:
            return .init(systemName: "gearshape.fill")
        }
    }
}
