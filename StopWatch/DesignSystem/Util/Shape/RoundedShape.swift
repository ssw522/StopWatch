//
//  RoundedShape.swift
//  Receive
//
//  Created by iOS신상우 on 7/25/24.
//

import SwiftUI

public struct RoundedShape: Shape {
    private var topLeft: CGFloat
    private var topRight: CGFloat
    private var bottomLeft: CGFloat
    private var bottomRight: CGFloat
    
    public init(
        topLeft: CGFloat,
        topRight: CGFloat,
        bottomLeft: CGFloat,
        bottomRight: CGFloat
    ) {
        self.topLeft = topLeft
        self.topRight = topRight
        self.bottomLeft = bottomLeft
        self.bottomRight = bottomRight
    }
    
    public init(all: CGFloat) {
        self.topLeft = all
        self.topRight = all
        self.bottomLeft = all
        self.bottomRight = all
    }
    
    public init(radiusToken: RadiusToken) {
        self.topLeft = radiusToken.topLeft
        self.topRight = radiusToken.topRight
        self.bottomLeft = radiusToken.bottomLeft
        self.bottomRight = radiusToken.bottomRight
    }
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX + topLeft, y: rect.minY))
        
        //top-right corner
        path.addLine(to: CGPoint(x: rect.maxX - topRight, y: rect.minY))
        path.addArc(
            center: CGPoint(x: rect.maxX - topRight, y: rect.minY + topRight),
            radius: topRight,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        
        // bottom-right corner
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - bottomRight))
        path.addArc(
            center: CGPoint(x: rect.maxX - bottomRight, y: rect.maxY - bottomRight),
            radius: bottomRight,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        
        // bottom-left corner
        path.addLine(to: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY))
        path.addArc(
            center: CGPoint(x: rect.minX + bottomLeft, y: rect.maxY - bottomLeft),
            radius: bottomLeft,
            startAngle: .degrees(90),
            endAngle: .degrees(180),
            clockwise: false
        )
        
        // top-left corner
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + topLeft))
        path.addArc(
            center: CGPoint(x: rect.minX + topLeft, y: rect.minY + topLeft),
            radius: topLeft,
            startAngle: .degrees(180),
            endAngle: .degrees(270),
            clockwise: false
        )
        
        return path
    }
}

public extension Shape {
    var asAnyShape: AnyShape {
        AnyShape(self)
    }
}
