//
//  CircleProgressView.swift
//  StopWatch
//
//  Created by iOS신상우 on 11/24/24.
//

import SwiftUI

struct CircleProgressView: View {
    @State var value: CGFloat = 0.0
    @State var style: CircleProgressStyle = .s
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: style.lineWidth)
                .frame(width: style.length, height: style.length)
                .foregroundStyle(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 10, y: 10)
            Circle()
                .stroke(lineWidth: 0.2)
                .frame(width: style.length-style.lineWidth-1, height: style.length-style.lineWidth-1)
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black.opacity(0.3), .clear]), startPoint: .bottomTrailing, endPoint: .topLeading))
                .overlay {
                    Circle()
                        .stroke(.black.opacity(0.1), lineWidth: 2)
                        .blur(radius: 5)
                        .mask {
                            Circle()
                                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        }
                }
            Circle()
                .trim(from: 0, to: value)
                .stroke(style: StrokeStyle(lineWidth: style.lineWidth, lineCap: .round))
                .frame(width: style.length, height: style.length)
                .rotationEffect(.degrees(-90))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
            NumValue(displayedValue: value, color: .black, style: style)
        }
        .onTapGesture {
            withAnimation(.spring().speed(0.5)) {
                value = 0.7
            }
        }
    }
}

enum CircleProgressStyle {
    case xs
    case s
    case m
    case l
    case xl
    
    var length: CGFloat {
        switch self {
        case .xs:
            32
        case .s:
            80
        case .m:
            120
        case .l:
            160
        case .xl:
            200
        }
    }
    
    var lineWidth: CGFloat {
        switch self {
        case .xs:
            4
        case .s:
            8
        case .m:
            12
        case .l:
            16
        case .xl:
            24
        }
    }
    
    var font: Typography {
        switch self {
        case .xs:
            return .caption3
        case .s:
            return .label2
        case .m:
            return .subTitle2
        case .l:
            return .subTitle1
        case .xl:
            return .title1
        }
    }
}

struct NumValue: View {
    var displayedValue: CGFloat
    var color: Color
    @State var style: CircleProgressStyle
    
    var body: some View {
        Text("\(Int(displayedValue*100))%")
            .setTypo(style.font)
    }
}

#Preview {
    CircleProgressView(style: .xs)
    CircleProgressView(style: .s)
    CircleProgressView(style: .m)
    CircleProgressView(style: .l)
    CircleProgressView(style: .xl)
}
