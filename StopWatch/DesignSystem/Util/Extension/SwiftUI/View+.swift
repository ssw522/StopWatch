//
//  View+.swift
//  Receive
//
//  Created by iOS신상우 on 7/28/24.
//

import SwiftUI

public extension View {
    /// 임시
    static var identifier: String { "\(Self.self)" }
    
    var viewController: UIViewController {
        ViewWrapper() { self }
    }
    
    var viewControllerClear: UIViewController {
        ViewWrapper(backgroundColor: .clear) { self }
    }
    
    @ViewBuilder func roundedBorder(
        _ color: Color = .black,
        radius: CGFloat = 8,
        linewidth: CGFloat = 1
    ) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius))
            .overlay {
                RoundedRectangle(cornerRadius: radius)
                    .stroke(color, lineWidth: linewidth)
            }
    }
    
    @ViewBuilder func roundedBorder(
        _ color: Color = .getColor(.line_assistive),
        topLeftRadius: CGFloat = 8,
        topRightRadius: CGFloat = 8,
        bottomLeftRadius: CGFloat = 8,
        bottomRightRadius: CGFloat = 8,
        linewidth: CGFloat = 1
    ) -> some View {
        self
            .clipShape(
                .rect(
                    topLeadingRadius: topLeftRadius,
                    bottomLeadingRadius: bottomLeftRadius,
                    bottomTrailingRadius: bottomRightRadius,
                    topTrailingRadius: topRightRadius
                )
            )
            .overlay {
                RoundedShape(
                    topLeft: topLeftRadius,
                    topRight: topRightRadius,
                    bottomLeft: bottomLeftRadius,
                    bottomRight: bottomRightRadius
                )
                .stroke(color, lineWidth: linewidth)
            }
    }
    
    @ViewBuilder 
    func hideKeyboardOnTapBackground(background: UIColor = UIColor.systemBackground) -> some View {
        self
            .background(
                Color(background)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            )
    }
    
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func isLoading(_ state: Bool) -> some View {
        self
            .disabled(state)
            .overlay {
                if state {
                    ProgressView()
                        .progressViewStyle(.circular)
                }
            }
    }
    
    func hSpacing(alignment: Alignment = .leading) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
}

