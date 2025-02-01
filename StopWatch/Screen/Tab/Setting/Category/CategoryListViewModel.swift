//
//  CategoryListViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/22/25.
//

import Foundation
import SwiftUI

final class CategoryListViewModel: ViewModelable {
    let coordinator: CategoryCoordinator
    @Published var state: State
    
    private let dependency: DependencyBox
    
    init(
        coordinator: CategoryCoordinator,
        state: State = .init(),
        dependency: DependencyBox = .live
    ) {
        self.coordinator = coordinator
        self.state = state
        self.dependency = dependency
    }
    
    struct State {
        var categories: [Category] = []
        var categoryName: String = ""
        var updateName: String = ""
        var isEditMode: Bool = false
        var selectedList: [Category] = []
    }
    
    enum Action {
        case fetchData
        case pop
        case didTapCreate
        case editCategoryName(String)
        case create(name: String)
        case didTapCategory(category: Category)
    }
    
    func reduce(_ action: Action) {
        switch action {
            
        case .fetchData:
            state.categories = (try? categoryRepo.getAll()) ?? []
            
        case .pop:
            coordinator.setFlow(.finish)
            
        case .editCategoryName(let name):
            state.categoryName = name
            
        case .didTapCreate:
            coordinator.showAlert(
                .init(
                    title: "카테고리 이름 입력",
                    message: .none,
                    inputMessage: Binding(
                        get: { self.state.categoryName },
                        set: { self.state.categoryName = $0 }
                    )
                )
                .addAction(title: "취소", style: .cancel, action: { [weak self] in
                    self?.state.categoryName = ""
                    self?.coordinator.dismiss(animated: false)
                })
                .addTextFieldAction(title: "추가", style: .primary, action: { [weak self] in
                    self?.coordinator.dismiss(animated: false)
                    self?.reduce(.create(name: self?.state.categoryName ?? ""))
                    self?.state.categoryName = ""
                })
            )
            
        case .create(let name):
            do {
                let newCateogry = Category(name: name)
                try categoryRepo.create(entity: newCateogry)
                state.categories.append(newCateogry)
            } catch {
                coordinator.showToast("카테고리 생성 실패")
            }
        
        case .didTapCategory(let category):
            let viewModel = CategoryBottomSheetViewModel(coordinator: coordinator, category: category, delegate: self)
            let view = CategoryBottomSheetView(viewModel: viewModel).panModal(height: .none)
            
            coordinator.presentPanModals(view)
        }
    }
    
    var categoryRepo: any CategoryRepository {
        dependency.resolve()
    }
}


extension CategoryListViewModel: CategoryBottomSheetViewModelDelegate {
    func deleteCategory(with category: Category) {
        do {
            let name = category.name
            try categoryRepo.delete(entity: category)
            
            if let index = state.categories.firstIndex(of: category) {
                state.categories.remove(at: index)
            }
            
            coordinator.showToast("'\(name)'가 삭제되었습니다.")
            coordinator.dismiss()
        } catch {
            coordinator.showToast("삭제 실패")
        }
    }
    
    func didTappedUpdateName(with category: Category) {
        coordinator.dismiss() { [weak self] in
            guard let self else { return }
            
            self.coordinator.showAlert(
                .init(
                    title: "이름 변경",
                    message: "'\(category.name)'의 이름을 변경합니다",
                    inputMessage: Binding(
                        get: { self.state.updateName },
                        set: { self.state.updateName = $0 }
                    )
                )
                .addAction(title: "취소", style: .cancel, action: { [weak self] in
                    self?.state.updateName = ""
                    self?.coordinator.dismiss(animated: false)
                })
                .addAction(title: "변경", style: .primary, action: { [weak self] in
                    self?.coordinator.dismiss(animated: false)
                    
                    self?.updateName(with: category, newName: self?.state.updateName ?? "")
                    self?.state.updateName = ""
                })
            )
        }
    }
    
    func updateName(with category: Category, newName: String) {
        do {
            try categoryRepo.update(
                entity: category,
                keypaths: [(\.name, newName )]
            )
            
            if let index = state.categories.firstIndex(of: category) {
                state.categories.remove(at: index)
                reduce(.fetchData)
            }
            
            coordinator.showToast("'\(category.name)'가 \(category.name)으로 변경되었습니다.")
        } catch {
            coordinator.showToast("업데이트 실패")
        }
    }
}
