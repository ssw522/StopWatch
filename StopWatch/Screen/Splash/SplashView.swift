//
//  SplashView.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/23/24.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        Color.white
            .onAppear {
                viewModel.reduce(.appRoute)
            }
    }
}
