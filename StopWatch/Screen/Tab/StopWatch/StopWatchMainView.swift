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
                playPauseButton
                FixedSpacer(40)
                timeHistoryView
                FixedSpacer(24)
            }
            .frame(maxWidth: .infinity)
            .overlay(alignment: .top) {
                VStack(spacing: .zero) {
                    
                    FixedSpacer(16)
                }
            }
        }
    }
    
    var displayView: some View {
        TotalTimeView(value: 0)
            .overlay {
                Text("02 : 43 : 12")
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
            TimeHistoryCell(date: .now, todo: "프로그래밍", todoTime: "1시간 20분")
            TimeHistoryCell(date: .now, todo: "영어 단어 암기", todoTime: "50분")
            TimeHistoryCell(date: .now, todo: "가슴 운동", todoTime: "1시간 20분")
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
    StopWatchMainView(viewModel: .init(coordinator: AppCoordinator.shared, state: .init()))
}
