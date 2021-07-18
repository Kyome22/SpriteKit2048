//
//  SwipeDirection.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/14.
//

import CoreGraphics

enum SwipeDirection {
    case left
    case top
    case right
    case bottom
    
    init(radian: CGFloat) {
        switch radian {
        case (0.25 * CGFloat.pi ..< 0.75 * CGFloat.pi): self = .top
        case (-0.25 * CGFloat.pi ..< 0.25 * CGFloat.pi): self = .right
        case (-0.75 * CGFloat.pi ..< -0.25 * CGFloat.pi): self = .bottom
        default: self = .left
        }
    }
}
