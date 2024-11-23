//
//  MainTabView.swift
//  Receive
//
//  Created by iOS신상우 on 7/29/24.
//

import SwiftUI

struct MainTabView: View {

    @StateObject var viewModel: TabViewModel
    
    init(viewModel: TabViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        WithDesignSystem {
            TabView(selection: $viewModel.state.currentTab) {
                ForEach(TabItem.allCases, id: \.self) { tabItem in
                    switch viewModel.state.currentTab {
                    case .todo:
                        //                        HomeView(viewModel: viewModel.homeViewModel)
                        //                            .tag(tabItem)
                        EmptyView()
                        
                    case .stopWatch:
                        //                        PolicyView(viewModel: viewModel.policyViewModel)
                        //                            .tag(tabItem)
                        EmptyView()
                        
                    case .chart:
                        //                        FeedView(viewModel: viewModel.feedViewModel)
                        //                            .tag(tabItem)
                        EmptyView()
                        
                    case .setting:
                        //                        SettingView(viewModel: viewModel.settingViewModel)
                        //                            .tag(tabItem)
                        EmptyView()
                    
                    }
                }
            }
            mainTabBar()
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder func mainTabBar() -> some View {
        HStack(spacing: 43) {
            ForEach(TabItem.allCases, id: \.self) { tabItem in
                tabItemCell(tabItem)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
        .frame(height: 88)
        .background(Color.white)
        .roundedBorder(
            topLeftRadius: 16,
            topRightRadius: 16,
            bottomLeftRadius: .zero,
            bottomRightRadius: .zero
        )
    }
    
    @ViewBuilder func tabItemCell(_ item: TabItem) -> some View {
        let isCurrentTab = self.viewModel.state.currentTab == item
        Button(action: {
            self.viewModel.reduce(.didSelectTab(item))
        }, label: {
            VStack(spacing: 4) {
                item.tabIcon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                Text(item.title)
            }
            .setTypo(.caption2)
            .foregroundStyle(isCurrentTab ? Color.black : Color.blue)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 12)
        })
    }
}

#Preview {
    MainTabView(
        viewModel: TabViewModel(
            coordinator: MainTabCoordinator()
        )
    )
}
