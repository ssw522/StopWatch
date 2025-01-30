//
//  BottomSheetView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/30/25.
//

import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Environment(\.dismiss) var dismiss
    @State var isOpen: Bool = false
    @State var offset: CGFloat = 0
    @ViewBuilder var content: () -> Content
    var radius: CGFloat = 16
    
    var body: some View {
        ZStack {
            Color.getColor(.dim)
            VStack(spacing: .zero) {
                Spacer()
                if isOpen {
                    content()
                        .frame(height: 200)
                        .clipShape(.rect(cornerRadius: radius))
                        .transition(.move(edge: .bottom))
                        .offset(y: offset)
                        .gesture(DragGesture()
                            .onChanged{ drag in
                                if drag.translation.height > 0 {
                                    offset = drag.translation.height
                                }
                                
                                if drag.translation.height > 100 {
                                    isOpen = false
                                    dismiss()
                                }
                            }
                            .onEnded { drag in
                                withAnimation {
                                    offset = .zero
                                }
                            }
                        )
                }
            }
            .animation(.linear, value: isOpen)
            
        }
        .ignoresSafeArea()
        .onAppear {
            isOpen = true
        }
    }
}

struct BottomSheetExampleView: View {
    
    var body: some View {
        BottomSheetView {
            Color.red
        }
    }
}
#Preview {
    BottomSheetExampleView()
}
