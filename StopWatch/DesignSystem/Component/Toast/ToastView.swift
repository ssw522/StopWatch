//
//  ToastView.swift
//  Receive
//
//  Created by iOS신상우 on 7/27/24.
//

import SwiftUI

public struct ToastView: View {
    public var message: String
    public var duration: Double
    
    /// 나타나고 사라지는 트랜지션 시간
    private let transitionDuration: Double = 0.3
    
    @State private var isVisible: Bool = false
    @State private var offsetY: CGFloat = .zero
    
    public var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                if isVisible {
                    Text(message)
                        .setTypo(.label1)
                        .foregroundStyle(Color.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.getColor(.gray_text).blur(radius: 0.4))
                        .clipShape(.rect(cornerRadius: 16))
                        .padding(.horizontal, 24)
                        .offset(y: offsetY)
                        .opacity(1 - abs(offsetY) / 100.0)
                        .onAppear {
                            withAnimation(.easeOut(duration: transitionDuration)) {
                                offsetY = .zero
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + duration - transitionDuration) {
                                withAnimation(.easeIn(duration: transitionDuration)) {
                                    offsetY = 100
                                } completion: {
                                    isVisible = false
                                }
                            }
                        }
                }
            }
        }
        .onAppear {
            withAnimation {
                offsetY = 100
                isVisible = true
            }
        }
    }
}

#Preview {
    ToastView(message: "테스트 토스트 메세지 입니다.", duration: 2.0)
}
