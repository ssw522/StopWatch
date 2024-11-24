//
//  TodoView.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/23/24.
//

import SwiftUI

struct TodoView: View {
    
    var body: some View {
        WithDesignSystem {
            
        } content: {
            ScrollView {
                VStack(spacing: .zero) {
                    calendarView
                    FixedSpacer(16)
                    todayTodoListView
                }
            }
            .scrollIndicators(.hidden)
            FixedSpacer(12)
            bottomButton
            FixedSpacer(12)
        }
    }
}

private extension TodoView {
    var calendarView: some View {
        Color.gray
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .overlay {
                Text("주 단위캘린더")
            }
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
        Button {
            
        } label: {
            Text("New Todo")
                .setTypo(.label2)
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.gray)
                .clipShape(.capsule)
        }
        .padding(.horizontal, 16)
    }
}

#Preview(body: {
    TodoView()
})

