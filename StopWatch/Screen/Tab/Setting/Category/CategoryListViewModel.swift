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
    }
    
    enum Action {
        case fetchData
        case pop
        case didTapCreate
        case editCategoryName(String)
        case create(name: String)
        
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
                        set: { self.reduce(.editCategoryName($0)) }
                    )
                )
                .addAction(title: "취소", style: .cancel, action: { [weak self] in
                    self?.state.categoryName = ""
                    self?.coordinator.dismiss()
                })
                .addAction(title: "추가", style: .primary, action: { [weak self] in
                    self?.coordinator.dismiss()
                    self?.reduce(.create(name: self?.state.categoryName ?? ""))
                    
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
        }
    }
    
    var categoryRepo: any CategoryRepository {
        dependency.resolve()
    }
}
