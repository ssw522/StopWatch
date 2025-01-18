//
//  StatisticMainView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

struct StatisticMainView: View {
    @StateObject var viewModel: StatisticMainViewModel
    
    var body: some View {
        WithDesignSystem {
            
        } content: {
            VStack(spacing: .zero) {
                Spacer()
                preparingView
                Spacer()
            }
        }
    }
    
    var preparingView: some View {
        VStack(spacing: 16) {
            Text("🚧")
                .font(.pretendard(size: 60, weight: .semibold))
            Text("해당 기능은 준비중입니다. (_ _)")
                .setTypo(.label1)
                .foregroundStyle(Color.getColor(.text_assistive))
        }
    }
}

#Preview {
    StatisticMainView(viewModel: .init(coordinator: AppCoordinator.shared, state: .init()))
}
