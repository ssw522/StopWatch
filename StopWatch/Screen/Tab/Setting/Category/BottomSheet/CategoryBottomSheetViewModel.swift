//
//  CategoryBottomSheetViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/31/25.
//

import SwiftUI

protocol CategoryBottomSheetViewModelDelegate: AnyObject {
    func deleteCategory(with category: Category)
    func didTappedUpdateName(with category: Category)
}

final class CategoryBottomSheetViewModel: ViewModelable {
    let coordinator: any CoordinatorType
    
    let category: Category
    weak var delegate: CategoryBottomSheetViewModelDelegate?
    
    private let dependency: DependencyBox
    
    @Published var state: State = .init()
    
    init(
        coordinator: any CoordinatorType,
        dependency: DependencyBox = .live,
        category: Category,
        delegate: CategoryBottomSheetViewModelDelegate?
    ) {
        self.coordinator = coordinator
        self.dependency = dependency
        self.category = category
        self.delegate = delegate
    }
    
    struct State {
        var updateName: String = ""
    }
    
    enum Action {
        case didTapDelete
        case didTapUpdateCategoryName
    }
    
    func reduce(_ action: Action) {
        switch action {
            
        case .didTapDelete:
            delegate?.deleteCategory(with: category)
            
        case .didTapUpdateCategoryName:
            delegate?.didTappedUpdateName(with: category)
        }
    }
}

private extension CategoryBottomSheetViewModel {
    var categoryRepo: any CategoryRepository {
        dependency.resolve()
    }
}
