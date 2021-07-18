//
//  ButtonNode.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import SpriteKit

class ButtonNode: SKShapeNode {
    
    var pushHandler: (() -> Void)?
    
    init(size: CGSize, fillColor: UIColor, title: String, titleColor: UIColor) {
        super.init()
        let origin = CGPoint(x: -0.5 * size.width, y: -0.5 * size.height)
        let rect = CGRect(origin: origin, size: size)
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        self.path = bezierPath.cgPath
        self.fillColor = fillColor
        self.strokeColor = .clear
        self.isUserInteractionEnabled = true
        
        let titleNode = SKLabelNode(text: title)
        titleNode.fontColor = titleColor
        titleNode.fontName = UIFont.monospacedSystemFont(ofSize: 1, weight: .bold).fontName
        titleNode.fontSize = 0.4 * size.height
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        self.addChild(titleNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 0.8
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
        if let touch = touches.first {
            if self.path!.boundingBox.contains(touch.location(in: self)) {
                pushHandler?()
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.alpha = 1.0
    }
    
}

