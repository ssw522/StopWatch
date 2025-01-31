//
//  TodoStorageView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/29/25.
//

import SwiftUI

struct TodoStorageView: View {
    @StateObject var viewModel: TodoStorageViewModel
    
    var body: some View {
        WithDesignSystem {
            TopNavigation(
                leadingItem: (Image(.chevronLeft), {
                    viewModel.reduce(.pop)
                }), centerTitle: "보관함"
            )
            .suffix {
                Button {
                    viewModel.reduce(.changeEditMode)
                } label: {
                    Text(viewModel.state.isEditMode ? "Done" :"Edit")
                        .setTypo(.label2)
                }
                FixedSpacer(24)
            }
        } content: {
            VStack(spacing: .zero) {
                if viewModel.state.todoList.isNotEmpty {
                    listView
                } else {
                    emptyView
                }
            }
            .overlay {
                if viewModel.state.isPresentedModalCalendar {
                    SystemCalendarModalView(
                        isPresented: $viewModel.state.isPresentedModalCalendar
                    ) {
                        viewModel.reduce(.changeDate($0))
                    }
                }
            }
            
        } bottomButton: {
            if viewModel.state.isEditMode {
                editModeBottomView
            }
        }
        .onAppear {
            viewModel.reduce(.fetchData)
        }
        .animation(.spring, value: viewModel.state.isEditMode)
        .animation(.spring, value: viewModel.state.todoList)
        .animation(.spring, value: viewModel.state.isPresentedModalCalendar)
        .animation(.spring, value: viewModel.state.selectedList)
    }
    
    var listView: some View {
        ScrollView {
            VStack(spacing: 12) {
                FixedSpacer(12)
                ForEach(viewModel.state.todoList, id: \.id) { todo in
                    Button {
                        viewModel.reduce(.selectTodo(todo))
                    } label: {
                        TodoStorageCell(
                            todo: todo,
                            isEditMode: viewModel.state.isEditMode,
                            isSelected: viewModel.state.selectedList.contains(todo)
                        )
                    }
                    .disabled(!viewModel.state.isEditMode)
                }
            }
        }
        .animation(.spring, value: viewModel.state.todoList)
        .padding(.horizontal, 20)
    }
    
    var emptyView: some View {
        VStack(spacing: 8) {
            Spacer()
            Text("🫥")
                .font(.pretendard(size: 60, weight: .bold))
            Text("보관함이 비었어요 추가해주세요")
                .setTypo(.body1)
                .foregroundStyle(Color.getColor(.text_normal))
            Spacer()
        }
    }
    
    var editModeBottomView: some View {
        HStack(spacing: 12) {
            Button {
                viewModel.reduce(.delete)
            } label: {
                Text("삭제")
                    .hSpacing(alignment: .center)
                    .setTypo(.label1)
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 12)
                    .background(viewModel.state.selectedList.isNotEmpty ? Color.getColor(.gray_text) : .getColor(.fill_disable))
                    .clipShape(.rect(cornerRadius: 12))
                    .disabled(viewModel.state.selectedList.isEmpty)
            }
            
            Button {
                viewModel.reduce(.exportTodo)
                
            } label: {
                Text("꺼내기")
                    .hSpacing(alignment: .center)
                    .setTypo(.label1)
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 12)
                    .background(viewModel.state.selectedList.isNotEmpty ? Color.getColor(.gray_text) : .getColor(.fill_disable))
                    .clipShape(.rect(cornerRadius: 12))
                    .disabled(viewModel.state.selectedList.isEmpty)
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    TodoStorageView(viewModel: .init(coordinator: .init(navigationController: .default(), parentCoordinator: .none), state: .init()))
}
