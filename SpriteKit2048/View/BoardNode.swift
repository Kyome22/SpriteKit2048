//
//  BoardNode.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import SpriteKit

class BoardNode: SKShapeNode {
    
    private var beganPos: CGPoint? = nil // タッチの開始点
    
    var swipedHandler: ((_ swipe: SwipeDirection) -> Void)?
    
    init(rectOf side: CGFloat) {
        super.init()
        self.name = "board"
        let rect = CGRect(origin: CGPoint(-0.5 * side), size: CGSize(side))
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: 8)
        self.path = bezierPath.cgPath
        self.fillColor = UIColor.board
        self.strokeColor = .clear
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, self.isUserInteractionEnabled {
            beganPos = touch.location(in: self)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let beganPos = beganPos, let touch = touches.first {
            let location = touch.location(in: self)
            if 50 < location.length(from: beganPos) {
                self.isUserInteractionEnabled = false
                self.beganPos = nil
                swipedHandler?(SwipeDirection(radian: location.radian(from: beganPos)))
            }
        }
    }
    
    func userInteractionOn() {
        self.isUserInteractionEnabled = true
    }
    
    func getTileNode(withName name: String) -> TileNode? {
        return self.childNode(withName: name) as? TileNode
    }
    
    func removeAllTile() {
        let tileNodes = self.children.filter({ node in
            return node.name?.hasPrefix("tile-") ?? false
        })
        self.removeChildren(in: tileNodes)
    }
    
}
