//
//  TodoView.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/23/24.
//

import SwiftUI

struct TodoView: View {
    @StateObject var viewModel: TodoViewModel
    @FocusState var isTyping: Bool
    
    var body: some View {
        WithDesignSystem {
            
        } content: {
            ScrollView {
                VStack(spacing: .zero) {
                    FixedSpacer(10)
                    calendarView
                    FixedSpacer(32)
                    todayTodoListView
                }
            }
            .scrollIndicators(.hidden)
            .overlay(alignment: .bottom) {
                VStack(spacing: .zero) {
                    bottomButton
                    FixedSpacer(12)
                }
                .opacity(isTyping ? 1.0 : 0.8)
            }
        }
    }
}

private extension TodoView {
    var calendarView: some View {
        SWWeeklyCalendarView(displayDate: .now)
    }
    
    var todayTodoListView: some View {
        VStack(spacing: 8) {
            HStack(spacing: .zero) {
                Text("Today")
                    .setTypo(.label2)
                    .foregroundStyle(Color.getColor(.text_assistive))
                Spacer()
            }
            .padding(.horizontal, 16)
            
            VStack(spacing: 8) {
                TodoCell(category: "프로그래밍", content: "알고리즘 풀기", date: .now, state: .circle)
                TodoCell(category: "프로그래밍", content: "프로젝트 회의 진행", date: .now, state: .triangle)
                TodoCell(category: "영어", content: "단어 200개 외우기", state: .circle)
                TodoCell(category: "영어", content: "영어강의 2개 듣기", state: .xmark)
                TodoCell(category: "운동", content: "헬스 1시간 하고오기", state: .circle)
            }
            .padding(.horizontal, 12)
        }
    }
    
    var bottomButton: some View {
        NewTodoView(
            text: Binding(
                get: { viewModel.state.newContent },
                set: { viewModel.reduce(.editNewTodoContent($0)) }),
            show: false,
            show2: false,
            isTyping: _isTyping) { todo in
                
            }
//        Button {
//            
//        } label: {
//            Text("New Todo")
//                .setTypo(.label2)
//                .foregroundStyle(Color.white)
//                .frame(maxWidth: .infinity)
//                .frame(height: 50)
//                .background(Color.gray)
//                .clipShape(.capsule)
//        }
//        .padding(.horizontal, 16)
    }
}

#Preview(body: {
    TodoView(viewModel: .init(coordinator: AppCoordinator.shared, state: .init()))
})

