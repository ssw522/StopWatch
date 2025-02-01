//
//  CategoryBottomSheetView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/31/25.
//

import SwiftUI

struct CategoryBottomSheetView: View {
    @StateObject var viewModel: CategoryBottomSheetViewModel
    
    var body: some View {
        WithDesignSystem {
            
        } content: {
            VStack(spacing: .zero) {
                FixedSpacer(12)
                Image(.handler)
                FixedSpacer(16)
                menuListView
            }
        }
    }
 
    // MARK: - menuList View
    var menuListView: some View {
        VStack(spacing: 12) {
            menuItem(image: Image(systemName: "pencil"), title: "이름 변경") {
                viewModel.reduce(.didTapUpdateCategoryName)
            }
            
            menuItem(image: Image(systemName: "trash"), title: "삭제", isDeleteCell: true) {
                viewModel.reduce(.didTapDelete)
            }
        }
        .padding(.horizontal, 24)
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
