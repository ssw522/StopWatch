//
//  TotalTimeView.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

struct TotalTimeView: View {
    @State var lineWidth: CGFloat = 6
    @State var value: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: lineWidth)
//                .frame(width: lineWidth, height: size.length)
                .foregroundStyle(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 15, x: 10, y: 10)
//            Circle()
//                .stroke(lineWidth: 0.2)
//                .frame(width: size.length-size.lineWidth-1, height: size.length-size.lineWidth-1)
//                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
//                .overlay {
//                    Circle()
//                        .stroke(.black.opacity(0.1), lineWidth: 2)
//                        .blur(radius: 5)
//                        .mask {
//                            Circle()
//                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                        }
//                }
            Circle()
                .trim(from: 0, to: value)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
//                .frame(width: size.length, height: size.length)
                .rotationEffect(.degrees(-90))
//                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundStyle(Color.getColor(.gray_text))
        }
    }
}

#Preview {
    TotalTimeView(lineWidth: 6, value: 0)
}
