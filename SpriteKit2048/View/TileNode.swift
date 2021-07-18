//
//  TileNode.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import SpriteKit

class TileNode: SKShapeNode {
    
    var numberNode: SKLabelNode!
    
    init(rectOf side: CGFloat, color: UIColor, name: String, number: Int) {
        super.init()
        
        self.name = name
        let rect = CGRect(origin: CGPoint(-0.5 * side), size: CGSize(side))
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        self.path = bezierPath.cgPath
        self.fillColor = color
        self.strokeColor = .clear
        
        // ラベルを追加する
        numberNode = SKLabelNode(text: "\(number)")
        numberNode.name = "number"
        numberNode.fontColor = number < 8 ? UIColor.tileFontBlack : UIColor.tileFontWhite
        numberNode.fontName = UIFont.monospacedSystemFont(ofSize: 1, weight: .bold).fontName
        numberNode.fontSize = fontSize(from: number)
        numberNode.horizontalAlignmentMode = .center
        numberNode.verticalAlignmentMode = .center
        numberNode.position = .zero
        self.addChild(numberNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fontSize(from number: Int) -> CGFloat {
        let tileSide =  self.frame.width
        switch String(number).count {
        case 1, 2: return 0.5 * tileSide
        case 3: return 0.4 * tileSide
        case 4: return 0.32 * tileSide
        default: return 0.28 * tileSide
        }
    }
    
}

