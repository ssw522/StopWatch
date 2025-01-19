//
//  SettingView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

struct SettingView: View {
    @StateObject var viewModel: SettingViewModel
    
    var body: some View {
        WithDesignSystem {
            HStack(spacing: .zero) {
                Text("설정")
                    .setTypo(.subTitle1)
                Spacer()
            }
            .padding(.horizontal, 24)
        } content: {
            VStack(spacing: 8) {
                FixedSpacer(16)
                HStack(spacing: 8) {
                    Text("📣")
                    Text("필요하신 기능, 버그 많은 제보 부탁드립니다!")
                }
                
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.getColor(.background_primary))
                    .clipShape(.rect(cornerRadius: 16))
                    .setTypo(.body1)
                
                FixedSpacer(8)
                settingCell("알림 설정", icon: .init(systemName: "bell.fill")) {
                    viewModel.reduce(.notificationSetting)
                }
                settingCell("문의하기", icon: .init(systemName: "text.document.fill")) {
                    viewModel.reduce(.feedback)
                }
                let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? 1.0
                settingCell("앱 버전", icon: .init(systemName: "info.circle.fill"), content: "\(version)") {
                    
                }
            }
            .padding(.horizontal, 24)
        }
    }
    
    func settingCell(_ title: String, icon: Image, content: String? = .none, action: (()->Void)?) -> some View {
        Button {
            action?()
        } label: {
            HStack(spacing: 8) {
                icon
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(Color.getColor(.gray_fill_assistive))
                
                Text(title)
                    .setTypo(.body1)
                    .foregroundStyle(Color.getColor(.text_normal))
                Spacer()
                if let content {
                    Text(content)
                        .setTypo(.body2)
                        .foregroundStyle(Color.getColor(.text_assistive))
                }
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    SettingView(viewModel: .init(coordinator: SettingCoordinator(navigationController: .default(), parentCoordinator: AppCoordinator.shared), state: .init()))
}
