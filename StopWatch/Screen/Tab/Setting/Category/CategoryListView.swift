//
//  CategoryListView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/22/25.
//

import SwiftUI

struct CategoryListView: View {
    @StateObject var viewModel: CategoryListViewModel
    
    var body: some View {
        WithDesignSystem {
            TopNavigation(
                leadingItem: (Image(.chevronLeft), {
                    viewModel.reduce(.pop)
                }), centerTitle: "카테고리 목록"
            )
        } content: {
            if viewModel.state.categories.isNotEmpty {
                listView
            } else {
                emptyView
            }
        } bottomButton: {
            Button {
                viewModel.reduce(.didTapCreate)
            } label: {
                Text("카테고리 추가")
                    .setTypo(.body1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .padding(.vertical, 12)
                    .background(Color.getColor(.gray_text))
                    .clipShape(.rect(cornerRadius: 16))
                    .padding(.horizontal, 24)
            }
        }
        .onAppear {
            viewModel.reduce(.fetchData)
        }
    }
    
    var listView: some View {
        ScrollView {
            VStack(spacing: 12) {
                FixedSpacer(12)
                ForEach(viewModel.state.categories, id: \.id) { category in
                    Button {
                        viewModel.reduce(.didTapCategory(category: category))
                    } label: {
                        categoryCell(with: category)
                    }
                }
            }
        }
        .animation(.spring, value: viewModel.state.categories)
        .padding(.horizontal, 20)
    }
    
    var emptyView: some View {
        VStack(spacing: 8) {
            Spacer()
            Text("🫥")
                .font(.pretendard(size: 60, weight: .bold))
            Text("카테고리를 추가해주세요")
                .setTypo(.body1)
                .foregroundStyle(Color.getColor(.text_normal))
            Spacer()
        }
    }
    
    func categoryCell(with category: Category) -> some View {
        HStack(spacing: .zero) {
            Text(category.name)
            Spacer()
        }
        .setTypo(.label1)
        .padding()
        .foregroundStyle(Color.getColor(.gray_text))
        .background(Color.getColor(.background_primary))
        .clipShape(.rect(cornerRadius: 12))
    }
}

#Preview {
    CategoryListView(viewModel: .init(coordinator: .init(navigationController: .default(), parentCoordinator: AppCoordinator.shared)))
}
