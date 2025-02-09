//
//  TodoEditorBottomSheetView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/31/25.
//

import SwiftUI

struct TodoEditorBottomSheetView: View {
    @StateObject var viewModel: TodoEditorBottomSheetViewModel
    
    var body: some View {
        WithDesignSystem {
            
        } content: {
            VStack(spacing: .zero) {
                FixedSpacer(12)
                Image(.handler)
                FixedSpacer(16)
                updateCardView
                FixedSpacer(32)
                menuListView
                FixedSpacer(32)
                progressView
                FixedSpacer(12)
            }
        }
    }
    
    // MARK: - UpdateCardView
    var updateCardView: some View {
        HStack(spacing: 16) {
            Button {
                viewModel.reduce(.didTapUpdateDate)
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "calendar")
                    Text("날짜 변경")
                }
                .setTypo(.label1)
                .padding(.vertical, 12)
                .hSpacing(alignment: .center)
                .background(Color.getColor(.background_primary))
                .foregroundStyle(Color.getColor(.gray_text))
                .clipShape(.rect(cornerRadius: 12))
            }
            
            Menu {
                ForEach(viewModel.categoryList, id: \.id) { category in
                    Button {
                        viewModel.reduce(.didTapUpdateCategory(category))
                    } label: {
                        Text(category.name)
                    }
                }
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: "folder.badge.gearshape")
                    Text("카테고리 변경")
                }
                .setTypo(.label1)
                .padding(.vertical, 12)
                .hSpacing(alignment: .center)
                .background(Color.getColor(.background_primary))
                .foregroundStyle(Color.getColor(.gray_text))
                .clipShape(.rect(cornerRadius: 12))
            }
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - menuList View
    var menuListView: some View {
        VStack(spacing: 12) {
            menuItem(image: Image(systemName: "bell"), title: "알림 설정") {
                viewModel.reduce(.didTapNotificationSetting)
            }
            
            menuItem(image: Image(systemName: "archivebox"), title: "보관하기") {
                viewModel.reduce(.archive)
            }
            
            menuItem(image: Image(systemName: "trash"), title: "삭제", isDeleteCell: true) {
                viewModel.reduce(.didTapDelete)
            }
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - ProgressView
    var progressView: some View {
        VStack(spacing: .zero) {
            Text("진행도")
                .hSpacing()
                .setTypo(.label2)
                .foregroundStyle(Color.getColor(.gray_text))
                .padding(.horizontal, 24)
            FixedSpacer(12)
            
            HStack(spacing: 8) {
                Slider(
                    value: Binding(
                        get: { viewModel.state.progress },
                        set: { viewModel.reduce(.changeProgress($0))})
                ) { isEditing in
                    if !isEditing {
                        viewModel.reduce(.updateProgress(viewModel.state.progress))
                    }
                }
                .setTypo(.body2)
                .foregroundStyle(Color.getColor(.gray_text))
                .tint(Color.getColor(.gray_text))
                
                Text("\(Int(viewModel.state.progress*100))%")
                    .hSpacing(alignment: .center)
                    .foregroundStyle(Color.getColor(.gray_text))
                    .setTypo(.caption1)
                    .fixedSize()
            }
            .padding(.horizontal, 28)
        }
    }
    
    func menuItem(image: Image, title: String, isDeleteCell: Bool = false, action: (()->Void)?) -> some View {
        Button {
            action?()
        } label: {
            HStack(spacing: 10) {
                image
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(title)
                    .setTypo(.label1)
                Spacer()
            }
            .foregroundStyle(isDeleteCell ? .getColor(.caution_text_alternative) : Color.getColor(.gray_text))
        }
    }
}

#Preview {
    TodoEditorBottomSheetView(
        viewModel: .init(
            coordinator: AppCoordinator.shared, todo: .mockData1, categoryList: [], delegate: .none, updateTodoListHandler: .none
        )
    )
}
