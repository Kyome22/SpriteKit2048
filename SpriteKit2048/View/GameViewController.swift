//
//  GameViewController.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/11.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var skView: SKView!
    
    private var firstDidLayoutSubviews: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.backgroundColor = UIColor.background
        skView.presentScene(GameScene(size: self.view.bounds.size))
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
