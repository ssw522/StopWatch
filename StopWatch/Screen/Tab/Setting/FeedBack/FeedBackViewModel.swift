//
//  FeedBackViewModel.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import Foundation
import UIKit.UIPasteboard

final class FeedBackViewModel: ViewModelable {
    let coordinator: SettingCoordinator
    
    @Published var state: State = .init()
    let email = "iosdev.sw@gmail.com"
    
    init(coordinator: SettingCoordinator, state: State) {
        self.coordinator = coordinator
        self.state = state
    }
    
    struct State {
        var title = ""
        var content = ""
        var isActiveSendButton: Bool {
            title.isNotEmpty && content.isNotEmpty
        }
    }
    
    enum Action {
        case copyEmail
        case editTitle(String)
        case editContent(String)
        case didTapSend
    }
    
    func reduce(_ action: Action) {
        switch action {
        case .copyEmail:
            UIPasteboard.general.string = email
            coordinator.showToast("이메일 복사 완료")
            
        case .editTitle(let title):
            self.state.title = title
            
        case .editContent(let content):
            self.state.content = content
            
        case .didTapSend:
            let emailSender = EmailSender(
                toAddress: email,
                subject: state.title,
                body: state.content
            )
            
            Task { @MainActor in
                do {
                    try await emailSender.send(type: .apple(toAddress: email))
                    
                    coordinator.showToast("이메일 전송 완료")
                    coordinator.pop()
                } catch EmailSender.EmailSendError.failed {
                    coordinator.showToast("이메일 전송을 지원하지 않는 기기입니다.")
                }
                catch {
                    coordinator.showToast("이메일 전송 실패")
                }
            }
        }
    }
}
