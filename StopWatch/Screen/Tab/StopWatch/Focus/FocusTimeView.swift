//
//  FocusTimeView.swift
//  StopWatch
//
//  Created by iOS신상우 on 2/2/25.
//

import SwiftUI

struct FocusTimeView: View {
    @StateObject var viewModel: FocusTimeViewModel
    
    var body: some View {
        WithDesignSystem {
            
        } content: {
            VStack(spacing: .zero) {
                Spacer()
                displayView
                Spacer()
                selectTodoView
                FixedSpacer(16)
                saveButton
            }
        }
        .onAppear {
            viewModel.reduce(.onAppear)
        }
    }
    
    var displayView: some View {
        VStack(spacing: .zero) {
            TotalTimeView()
                .overlay {
                    let endDate = viewModel.state.endDate ?? .now
                    let time = endDate.timeIntervalSince1970 - viewModel.state.startDate.timeIntervalSince1970
                    let timeInterval = (time - viewModel.state.breakTime)
                    
                    Text(TimeFormatter.toTimeString(with: timeInterval))
                        .foregroundStyle(Color.getColor(.gray_assistive))
                        .font(.pretendard(size: 48, weight: .regular))
                }
                .padding(.horizontal, 32)
        }
    }
    
    var selectTodoView: some View {
        VStack(spacing: .zero) {
            Text("오늘 남은 할 일")
                .setTypo(.label1)
                .foregroundStyle(Color.getColor(.gray_text))
            FixedSpacer(12)
            
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(viewModel.state.todayTodoList, id: \.id) { todo in
                        Button {
                            viewModel.reduce(.didTapTodo(todo))
                        } label: {
                            let isSelected = viewModel.state.selectedTodo == todo
                            HStack(spacing: .zero) {
                                Text(todo.content)
                                    .setTypo(.body1)
                                    .foregroundStyle(Color.getColor(.gray_text))
                                Spacer()
                                Image(isSelected ? .checkFillOn : .checkFillOff)
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                    Spacer()
                }
                .hSpacing(alignment: .center)
                .padding(24)
                .background(Color.getColor(.background_primary))
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal, 24)
                
            }
            .frame(maxHeight: 180)
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)
        }
    }
    
    var saveButton: some View {
        Button {
            viewModel.reduce(.didTapSave)
        } label: {
            Text("Save")
                .setTypo(.label1)
                .foregroundStyle(Color.getColor(.white))
                .hSpacing(alignment: .center)
                .padding(.vertical, 12)
                .background(Color.getColor(.gray_text))
                .clipShape(.rect(cornerRadius: 20))
                .padding(.horizontal, 24)
        }
    }
}

#Preview {
    FocusTimeView(
        viewModel: .init(
            coordinator: .init(navigationController: .default()),
            state: .init(startDate: .now, endDate: .now.addingTimeInterval(3820), todayTodoList: [.mockData1, .mockData2]), delegate: .none
        )
    )
}

