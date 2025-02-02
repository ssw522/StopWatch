//
//  StopWatchMainView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

struct StopWatchMainView: View {
    @StateObject var viewModel: StopWatchMainViewModel
    
    var body: some View {
        WithDesignSystem {
            
        } content: {
            VStack(spacing: .zero) {
                FixedSpacer(16)
                InfiniteFlipToast(message: "뒤집어서 타이머를 시작해주세요.")
                FixedSpacer(40)
                displayView
                Spacer()
//                playPauseButton
                FixedSpacer(40)
                timeHistoryView
                FixedSpacer(24)
            }
            .frame(maxWidth: .infinity)
        }
        .onAppear {
            viewModel.reduce(.onAppear)
        }
    }
    
    var displayView: some View {
        TotalTimeView(value: 0)
            .overlay {
                Text(TimeFormatter.toTimeString(with: viewModel.state.todayFocusTime))
                    .foregroundStyle(Color.getColor(.gray_assistive))
                    .font(.pretendard(size: 48, weight: .regular))
            }
            .padding(.horizontal, 32)
        
    }
    
    var playPauseButton: some View {
        Button {
            
        } label: {
            Text("시작")
                .foregroundStyle(Color.white)
                .setTypo(.body1)
                .padding(.horizontal, 36)
                .padding(.vertical, 10)
                .background(Color.getColor(.gray_fill_normal))
                .clipShape(.capsule)
        }
    }
 
    var timeHistoryView: some View {
        VStack(spacing: 16) {
            if viewModel.state.recentTimeCheckList.isEmpty {
                Text("아직 집중한 시간이 없어요!")
                    .setTypo(.label2)
                    .foregroundStyle(Color.getColor(.gray_text))
            } else {
                ForEach(viewModel.state.recentTimeCheckList, id: \.id) { timeCheck in
                    TimeHistoryCell(
                        date: timeCheck.startDate,
                        todo: timeCheck.todo?.content ?? "",
                        todoTime: TimeFormatter.toTimeString(with: timeCheck.focusTime, format: .HHMMssKorean, useCompactTimeFormat: true)
                    )
                }
            }
        }
        .hSpacing()
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color.getColor(.background_primary))
        .clipShape(.rect(cornerRadius: 12))
        .padding(.horizontal, 24)
    }
}

#Preview {
    StopWatchMainView(viewModel: .init(coordinator: .init(navigationController: .default()), state: .init()))
}
