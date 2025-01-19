//
//  FeedBackView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

struct FeedBackView: View {
    @StateObject var viewModel: FeedBackViewModel
    
    var body: some View {
        WithDesignSystem(.white) {
            TopNavigation(
                leadingItem: (Image(.chevronLeft), {
                    viewModel.coordinator.pop()
                }),
                centerTitle: "문의하기"
            )
        } content: {
            ScrollView {
                VStack(spacing: .zero) {
                    FixedSpacer(40)
                    TitleView(
                        title: "여러분의 이야기를 들려주세요",
                        content: "궁금하신 점, 따끔한 조언, 응원의 메세지\n무엇이든 환영이에요."
                    )
                    FixedSpacer(24)
                    writeFeedBackView
    //                emailView
                }
            }
            .scrollIndicators(.hidden)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
            .padding(.horizontal, 16)
        } bottomButton: {
            Button {
                viewModel.reduce(.didTapSend)
            } label: {
                Text("전송")
                    .hSpacing(alignment: .center)
                    .padding()
                    .background(viewModel.state.isActiveSendButton ? Color.getColor(.gray_text) : .getColor(.fill_disable))
                    .clipShape(.rect(cornerRadius: 16))
                    .foregroundStyle(.white)
                    .padding(16)
                    .disabled(!viewModel.state.isActiveSendButton)
            }
        }
    }
    
    var writeFeedBackView: some View {
        VStack(spacing: .zero) {
            Text("제목")
                .hSpacing(alignment: .leading)
                .setTypo(.label3)
                .foregroundStyle(Color.getColor(.text_strong))
                .padding(.leading, 6)
            FixedSpacer(8)
            
            HStack(spacing: 8) {
                TextField("",
                          text: Binding(
                            get: { viewModel.state.title },
                            set: { viewModel.reduce(.editTitle($0)) }
                          )
                )
            }
            .padding(16)
            .background(Color.getColor(.background_primary))
            .clipShape(.rect(cornerRadius: 12))
            
            FixedSpacer(12)
            
            Text("내용")
                .hSpacing(alignment: .leading)
                .setTypo(.label3)
                .foregroundStyle(Color.getColor(.text_strong))
                .padding(.leading, 6)
            FixedSpacer(8)
            
            TextEditor(text: Binding(
                get: { viewModel.state.content },
                set: { viewModel.reduce(.editContent($0)) }
              )
            )
            .scrollContentBackground(.hidden)
            .frame(height: 340)
            .padding(16)
            .background(Color.getColor(.background_primary))
            .clipShape(.rect(cornerRadius: 12))
        }
    }
    
    var emailView: some View {
        VStack(spacing: .zero) {
            Text("개발자 이메일")
                .hSpacing(alignment: .leading)
                .setTypo(.label1)
                .foregroundStyle(Color.getColor(.text_strong))
            FixedSpacer(8)
            
            HStack(spacing: 8) {
                Image(systemName: "envelope.fill")
                    .foregroundColor(Color.getColor(.gray_assistive))
                Text(viewModel.email)
                    .foregroundStyle(Color.getColor(.text_normal))
                    .setTypo(.label2)
                Spacer()
                Button {
                    viewModel.reduce(.copyEmail)
                } label: {
                    Text("복사하기")
                        .setTypo(.label3)
                        .foregroundStyle(Color.getColor(.primary_normal))
                }
            }
            .padding(16)
            .background(Color.getColor(.background_primary))
            .clipShape(.rect(cornerRadius: 12))
        }
    }
}

#Preview {
    FeedBackView(viewModel: .init(coordinator: .init(navigationController: .default(), parentCoordinator: .none), state: .init()))
}
