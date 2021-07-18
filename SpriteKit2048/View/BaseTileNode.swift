//
//  BaseTileNode.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import SpriteKit

class BaseTileNode: SKShapeNode {
    
    init(rectOf side: CGFloat) {
        super.init()
        
        let rect = CGRect(origin: CGPoint(-0.5 * side), size: CGSize(side))
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        self.path = bezierPath.cgPath
        self.fillColor = UIColor.tileBase
        self.strokeColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
