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
                    if !show {
                        Text("New Todo").bold()
                            .matchedGeometryEffect(id: "text", in: animation)
                            .offset(y: 5)
                    } else {
                        VStack(spacing: .zero) {
                            ZStack(alignment: .topLeading) {
                                TextEditor(text: $text)
                                    .focused($isTyping)
                                    .scrollContentBackground(.hidden)
                                    .frame(width: 100)
                                if !isTyping {
                                    Text("\(Image(systemName: "pencil")) type here...")
                                        .foregroundStyle(Color.gray)
                                        .padding(.top, 8)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .matchedGeometryEffect(id: "text", in: animation)
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .frame(height: show ? 200: 60)
        .clipped()
    }
}

#Preview {
    NewTodoView(text: .constant("123"), show: true, show2: true, onSave: { _ in })
}
