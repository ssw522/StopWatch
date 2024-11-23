//
//  ViewModelable.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import Foundation

/// MVI 
public protocol ViewModelable: Reduceable, ObservableObject {
    
}

// MARK: - Example

/*
 class ExampleViewModel: ViewModelable {
     
     @Published var state: State = .init()
     
     struct State {
         var count: Int = 0
     }
     
     enum Action {
         case increased
     }
     
     func reduce(_ action: Action) {
         switch action {
         case .increased:
             state.count+=1
         }
     }
 }

 struct ExampleView: View {
     @ObservedObject var viewModel: ExampleViewModel
     
     var body: some View {
         VStack {
             Text("\(viewModel.state.count)")
             Button {
                 viewModel.reduce(.increased)
             } label: {
                 Text("증가")
             }
         }
     }
 }

 #Preview {
     ExampleView(viewModel: ExampleViewModel())
 }
 
 */
