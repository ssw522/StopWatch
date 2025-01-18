//
//  InfiniteFlipToast.swift
//  StopWatch
//
//  Created by iOS신상우 on 1/18/25.
//

import SwiftUI

struct InfiniteFlipToast: View {
    @State var message: String
    @State private var rotationAngle: Double = 0
    @State private var opacityValue: Double = 1.0

    var body: some View {
        Text(message)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .setTypo(.body2)
            .background(Color.getColor(.background_primary))
            .clipShape(.capsule)
            .opacity(opacityValue)
            .rotation3DEffect(.degrees(rotationAngle), axis: (x: 1, y: 0, z: 0))
            .onAppear {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: true)) {
                    rotationAngle = 180
                }
                withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                    opacityValue = 0.5
                }
            }
    }
}
