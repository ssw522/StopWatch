//
//  Reducable.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public protocol Reduceable: ObservableObject {
    
    associatedtype State
    associatedtype Action
    
    var state: State { get set }

    func reduce(_ action: Action)
}
