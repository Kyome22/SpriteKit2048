//
//  Extensions.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import CoreGraphics

extension Int {
    var cg: CGFloat {
        return CGFloat(self)
    }
}

extension CGPoint {
    init(_ scaler: CGFloat) {
        self.init(x: scaler, y: scaler)
    }
    
    func length(from: CGPoint) -> CGFloat {
        return sqrt(pow(self.x - from.x, 2.0) + pow(self.y - from.y, 2.0))
    }
    
    func radian(from: CGPoint) -> CGFloat {
        return atan2(self.y - from.y, self.x - from.x)
    }
}

extension CGSize {
    init(_ side: CGFloat) {
        self.init(width: side, height: side)
    }
}
