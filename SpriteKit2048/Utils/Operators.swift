//
//  Operators.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/11.
//

import CoreGraphics

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (left: CGFloat, right: CGPoint) -> CGPoint {
    return CGPoint(x: left * right.x, y: left * right.y)
}
