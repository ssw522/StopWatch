//
//  NewTodoView.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import SwiftUI

struct NewTodoView: View {
    @Binding var text: String
    @State var show = false
    @State var show2 = false
    @Namespace var animation
    @FocusState var isTyping: Bool
    
    var onSave: (Todo) -> Void
    
    var body: some View {
        VStack(spacing: .zero) {
            ZStack(alignment: show ? .topLeading : .center) {
                RoundedRectangle(cornerRadius: show ? 24 : 40)
                    .foregroundStyle(Color.gray)
                
                VStack(alignment: .leading) {
                    if show {
                        editNewTodoView
                    } else {
                        addTodoView
                    }
                }
                .frame(maxWidth: .infinity, alignment: show ? .leading : .center)
            }
        }
        .animation(.spring, value: show)
        .frame(height: show ? 200: 50)
        .padding(.horizontal, show ? 0 : 16)
        .clipped()
    }
}

private extension NewTodoView {
    var addTodoView: some View {
        Text("New Todo")
            .setTypo(.label2)
            .foregroundStyle(Color.white)
            .matchedGeometryEffect(id: "text", in: animation)
            .onTapGesture {
                show = true
            }
    }
    
    var editNewTodoView: some View {
        VStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Spacer()
                Button {
                    withAnimation {
                        show = false
                        text = ""
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.white)
                        .padding([.top, .trailing])
                }
            }
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .focused($isTyping)
                    .foregroundStyle(Color.white)
                    .scrollContentBackground(.hidden)
                if !isTyping {
                    Text("\(Image(systemName: "pencil")) What to do?")
                        .setTypo(.label2)
                        .foregroundStyle(Color.init(hex: "F4F4E4") ?? .white)
                        .padding(.top, 8)
                        .fixedSize(horizontal: true, vertical: false)
                        .matchedGeometryEffect(id: "text", in: animation)
                }
            }
            .padding([.bottom, .horizontal])
            Spacer()
        }
    }
}

#Preview {
    NewTodoView(text: .constant("123"), show: true, show2: true, onSave: { _ in })
}
