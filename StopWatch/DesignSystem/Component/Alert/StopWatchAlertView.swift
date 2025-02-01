//
//  StopWatchAlertView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/24/25.
//

import SwiftUI

struct StopWatchAlertView: View {
    @State private var animation: Bool = false
    
    let title: String
    let message: String?
    var actions: [StopWatchActionView] = []
    var inputMessage: Binding<String>?
    
    init(
        title: String,
        message: String?,
        inputMessage: Binding<String>? = nil
    ) {
        self.title = title
        self.message = message
        self.inputMessage = inputMessage
    }
    
    var body: some View {
        ZStack {
            Color.getColor(.dim)
            if animation {
                VStack(spacing: .zero) {
                    Text(title)
                        .setTypo(.label1)
                        .foregroundStyle(Color.getColor(.text_strong))
                    
                    if let message {
                        FixedSpacer(4)
                        Text(message)
                            .setTypo(.body2)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(Color.getColor(.text_alternative))
                    }
                    
                    if let inputMessage {
                        FixedSpacer(8)
                        TextField("", text: inputMessage)
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.getColor(.line_assistive), lineWidth: 1))
                        .setTypo(.label1)
                    }
                    FixedSpacer(20)
                    HStack(spacing: 8) {
                        ForEach(Array(0..<actions.count), id: \.self) { i in
                            actions[i]
                        }
                    }
                }
                .padding(.top, 24)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(Color.getColor(.background_secondary))
                .roundedBorder(
                    Color.getColor(.line_assistive),
                    radius: 16,
                    linewidth: 1
                )
                .padding(.horizontal, 48)
                .transition(.opacity)
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                animation = true
            }
        }
    }
}

extension StopWatchAlertView {
    func addAction(
        title: String,
        style: StopWatchActionView.ActionStyle,
        action: (()->Void)?
    ) -> StopWatchAlertView {
        
        var new = self
        let newAction = StopWatchActionView(
            title: title,
            style: style,
            action: action
        )

        new.actions.append(newAction)
        return new
    }
    
    func addTextFieldAction(
        title: String,
        style: StopWatchActionView.ActionStyle,
        action: (()->Void)?
    ) -> StopWatchAlertView {
        var new = self
        let newAction = StopWatchActionView(
            title: title,
            style: style,
            action: action
        )
        
        new.actions.append(newAction)
        return new
    }
}

struct StopWatchActionView: View {
    let title: String
    let style: ActionStyle
    let action: (()->Void)?
    
    var body: some View {
        Button {
            action?()
        } label: {
            Text(title)
                .setTypo(.label1)
                .foregroundStyle(style.foregroundColor)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(style.backgroundColor)
                .clipShape(.rect(cornerRadius: 8))
        }
    }
    
    enum ActionStyle {
        case cancel
        case destructive
        case primary
    }
}

extension StopWatchActionView.ActionStyle {
    var foregroundColor: Color {
        switch self {
        case .cancel:
            Color.getColor(.gray_alternative)
        case .destructive:
            Color.getColor(.white)
        case .primary:
            Color.getColor(.white)
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .cancel:
            Color.getColor(.fill_normal)
        case .destructive:
            Color.getColor(.caution_normal)
        case .primary:
            Color.getColor(.gray_text)
        }
    }
}

#Preview {
    StopWatchAlertView(
        title: "모달 제목",
        message: "일이삼사오육칠팔구십일이삼"
    )
    .addAction(
        title: "취소",
        style: .cancel,
        action: nil
    )
    .addAction(title: "나가기", style: .primary, action: nil)
}
