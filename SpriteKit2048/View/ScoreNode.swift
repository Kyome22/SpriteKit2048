//
//  ScoreNode.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import SpriteKit

class ScoreNode: SKShapeNode {
    
    var numberNode: SKLabelNode!
    
    init(size: CGSize, title: String, score: Int) {
        super.init()
        
        let origin = CGPoint(x: -0.5 * size.width, y: -0.5 * size.height)
        let rect = CGRect(origin: origin, size: size)
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        self.path = bezierPath.cgPath
        self.fillColor = UIColor.scoreBase
        self.strokeColor = .clear
        
        let titleNode = SKLabelNode(text: title)
        titleNode.fontColor = UIColor.scoreTitle
        titleNode.fontName = UIFont.monospacedSystemFont(ofSize: 1, weight: .medium).fontName
        titleNode.fontSize = 0.25 * size.height
        titleNode.horizontalAlignmentMode = .center
        titleNode.verticalAlignmentMode = .center
        titleNode.position = CGPoint(x: 0, y: 0.2 * size.height)
        self.addChild(titleNode)
        
        numberNode = SKLabelNode(text: String(score))
        numberNode.fontColor = UIColor.white
        numberNode.fontName = UIFont.monospacedSystemFont(ofSize: 1, weight: .bold).fontName
        numberNode.fontSize = 0.35 * size.height
        numberNode.horizontalAlignmentMode = .center
        numberNode.verticalAlignmentMode = .center
        numberNode.position = CGPoint(x: 0, y: -0.175 * size.height)
        self.addChild(numberNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateScore(_ score: Int) {
        numberNode.text = String(score)
    }
}
