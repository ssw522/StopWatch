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
                    calendarView
                    FixedSpacer(32)
                    if viewModel.state.todoList.isNotEmpty {
                        todayTodoListView
                    } else {
                        emptyView
                    }
                }
            }
            .onTapGesture {
                viewModel.state.isExpendedNewTodo = false
            }
            .scrollIndicators(.hidden)
            .overlay(alignment: .bottom) {
                VStack(spacing: .zero) {
                    bottomButton
                    FixedSpacer(12)
                }
            }
        }
        .onAppear {
            viewModel.reduce(.fetchDate)
        }
        .overlay {
            if viewModel.state.isPresentedModalCalendar {
                ZStack {
                    Color.getColor(.dim)
                        .ignoresSafeArea()
                        .onTapGesture {
                            viewModel.state.isPresentedModalCalendar = false
                        }
                    SystemCalendarModalView(
                        selectedDate: viewModel.state.currentDate,
                        isPresented: $viewModel.state.isPresentedModalCalendar) { date in
                            viewModel.reduce(.updateTodoDate(date))
                        }
                }
            }
        }
        .animation(.smooth(duration: 0.25), value: viewModel.state.isExpendedNewTodo)
        .animation(.easeInOut, value: viewModel.state.isPresentedModalCalendar)
    }
}

private extension TodoView {
    var emptyView: some View {
        VStack(spacing: .zero) {
            Spacer(minLength: 200)
            Text("오늘 추가된 할 일이 없어요")
                .setTypo(.label1)
                .foregroundStyle(Color.getColor(.text_disable))
            Spacer()
        }
    }
    
    var calendarView: some View {
        SWWeeklyCalendarView(
            displayDate: Binding(
                get: { viewModel.state.currentDate },
                set: { viewModel.reduce(.changeDate($0)) }
            )
        )
        .zIndex(1)
    }
     
    var todayTodoListView: some View {
        VStack(spacing: 8) {
            if viewModel.state.currentDate.formattedString(by: .yyyyMMdd) == Date.now.formattedString(by: .yyyyMMdd) {
                HStack(spacing: .zero) {
                    Text("Today")
                        .setTypo(.label2)
                        .foregroundStyle(Color.getColor(.text_assistive))
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            
            VStack(spacing: 8) {
                ForEach(viewModel.state.todoList, id: \.id) { todo in
                    Button {
                        viewModel.reduce(.didTapTodo(todo))
                    } label: {
                        TodoCell(todo: todo)
                            .gesture(
                                DragGesture()
                                    .onChanged { drag in
                                        if drag.translation.width > 80 {
                                            viewModel.reduce(.rightDrag(todo))
                                        } else if drag.translation.width < -80 {
                                            viewModel.reduce(.leftDrag(todo))
                                        }
                                    }
                            )
                    }
                }
            } 
            .padding(.horizontal, 12)
        }
    }
    
    var bottomButton: some View {
        HStack(spacing: .zero) {
            NewTodoView(
                isTyping: _isTyping,
                show: $viewModel.state.isExpendedNewTodo,
                categoryList: viewModel.state.categoryList
            ) { todo in
                viewModel.reduce(.addTodo(todo))
            } didTapAddCategory: {
                viewModel.reduce(.didTapCreateCategory)
            }
            
            if !viewModel.state.isExpendedNewTodo {
                Button {
                    viewModel.reduce(.didTapStorage)
                } label: {
                    Image(systemName: "archivebox.fill")
                        .padding()
                        .foregroundStyle(Color.getColor(.white))
                        .background(Color.getColor(.gray_text))
                        .clipShape(.circle)
                }
                FixedSpacer(12)
            }
        }
    }
}

#Preview(body: {
    TodoView(viewModel: .init(coordinator: TodoCoordinator.init(navigationController: .default(), parentCoordinator: .none), state: .init()))
})

