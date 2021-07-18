//
//  GameScene.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/11.
//

import SpriteKit

class GameScene: SKScene {
    
    private let LINES: Int = 4 // 2以上
    private let interval: Double = 0.05 // アニメーションの最小単位
    private let borderWidth: CGFloat = 8.0
    private let gameModel: GameModel
    private var contentNode: SKSpriteNode?
    private var bestScoreNode: ScoreNode?
    private var scoreNode: ScoreNode?
    private var boardNode: BoardNode?
    
    private var contentSize: CGSize {
        return CGSize(width: boardBoxSide, height: 1.35 * boardBoxSide)
    }
    private var scoreSize: CGSize {
        let unit = min(self.size.width, self.size.height)
        return CGSize(width: 0.25 * unit, height: 0.125 * unit)
    }
    private var buttonSize: CGSize {
        let unit = min(self.size.width, self.size.height)
        return CGSize(width: 0.3 * unit, height: 0.1 * unit)
    }
    private var boardSide: CGFloat {
        return 0.85 * min(self.size.width, self.size.height)
    }
    private var boardBoxSide: CGFloat {
        return boardSide + borderWidth
    }
    private var tileOffset: CGPoint {
        return CGPoint((1 - LINES.cg) / (2 * LINES.cg) * boardSide)
    }
    private var tileSide: CGFloat {
        return (boardSide - LINES.cg * borderWidth) / LINES.cg
    }
    
    override init(size: CGSize) {
        self.gameModel = GameModel(LINES: LINES)
        super.init(size: size)
        self.scaleMode = .aspectFit
        self.backgroundColor = UIColor.background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        putContentNode()
        putGameTitle()
        putScoreNodes()
        putNewGameButton()
        putBoard()
        newGame()
        
        // display all number tiles
        // for i in (0 ..< 16) {
        //     let h = pow(2, Double(i + 1))
        //     putTile(index: i, number: Int(h))
        // }
    }
    
    private func newGame() {
        gameModel.reset()
        scoreNode?.updateScore(0)
        boardNode?.removeAllTile()
        contentNode?.childNode(withName: "gameover")?.removeFromParent()
        putTile()
        putTile()
        boardNode?.userInteractionOn()
    }
    
    private func putContentNode() {
        contentNode = SKSpriteNode(color: UIColor.clear, size: contentSize)
        contentNode!.position = CGPoint(x: 0.5 * self.size.width, y: 0.5 * self.size.height)
        self.addChild(contentNode!)
    }
    
    private func putGameTitle() {
        let labelNode = SKLabelNode(text: "2048")
        labelNode.fontColor = UIColor.text
        labelNode.fontName = UIFont.monospacedSystemFont(ofSize: 1, weight: .bold).fontName
        labelNode.fontSize = scoreSize.height
        labelNode.horizontalAlignmentMode = .left
        labelNode.verticalAlignmentMode = .center
        labelNode.position = CGPoint(x: -0.5 * contentSize.width,
                                     y: 0.5 * (contentSize.height - scoreSize.height))
        contentNode?.addChild(labelNode)
    }
    
    private func putScoreNodes() {
        var x: CGFloat = 0.5 * (contentSize.width - scoreSize.width)
        let y: CGFloat = 0.5 * (contentSize.height - scoreSize.height)
        
        bestScoreNode = ScoreNode(size: scoreSize, title: "BEST", score: gameModel.bestScore)
        bestScoreNode!.position = CGPoint(x: x, y: y)
        contentNode?.addChild(bestScoreNode!)
        
        x -= scoreSize.width + 8
        scoreNode = ScoreNode(size: scoreSize, title: "SCORE", score: gameModel.score)
        scoreNode!.position = CGPoint(x: x, y: y)
        contentNode?.addChild(scoreNode!)
    }
    
    private func putNewGameButton() {
        let buttonNode = ButtonNode(size: buttonSize,
                                    fillColor: UIColor.newGameBase,
                                    title: "New Game",
                                    titleColor: UIColor.newGameTitle)
        let x: CGFloat = 0.5 * (contentSize.width - buttonSize.width)
        let y: CGFloat = 0.5 * (contentSize.height - buttonSize.height) - scoreSize.height - 8
        buttonNode.position = CGPoint(x: x, y: y)
        buttonNode.pushHandler = { [weak self] in
            self?.newGame()
        }
        contentNode?.addChild(buttonNode)
    }
    
    private func swiped(_ swipe: SwipeDirection) {
        if gameModel.shiftTiles(swipe: swipe) {
            updateTiles()
            let sequence = SKAction.sequence([
                SKAction.wait(forDuration: interval * Double(LINES - 1)),
                SKAction.run({ [weak self] in
                    guard let self = self else { return }
                    self.updateScore()
                    self.putTile()
                    if self.gameModel.judgeGameover() {
                        self.putGameover()
                    }
                }),
                SKAction.wait(forDuration: 2 * interval),
                SKAction.run({ [boardNode] in
                    boardNode?.userInteractionOn()
                })
            ])
            self.run(sequence)
        } else {
            boardNode?.userInteractionOn()
        }
    }
    
    private func tilePosition(with index: Int) -> CGPoint {
        let x = CGFloat(index % LINES) * (boardSide / LINES.cg)
        let y = CGFloat(index / LINES) * (boardSide / LINES.cg)
        return tileOffset + CGPoint(x: x, y: y)
    }
    
    private func putBoard() {
        boardNode = BoardNode(rectOf: boardBoxSide)
        let y: CGFloat = 0.5 * (contentSize.height - boardBoxSide) - buttonSize.height - scoreSize.height - 28
        boardNode!.position = CGPoint(x: 0, y: y)
        boardNode!.zPosition = 1
        boardNode?.swipedHandler = { [weak self] swipe in
            self?.swiped(swipe)
        }
        for i in (0 ..< LINES * LINES) {
            let tileNode = BaseTileNode(rectOf: tileSide)
            tileNode.position = tilePosition(with: i)
            boardNode!.addChild(tileNode)
        }
        contentNode?.addChild(boardNode!)
    }
    
    private func putTile(index: Int, number: Int) {
        let tileName = "tile-\(UUID().uuidString)"
        let tileNode = TileNode(rectOf: tileSide,
                                color: UIColor.tile(number: number),
                                name: tileName,
                                number: number)
        tileNode.position = tilePosition(with: index)
        tileNode.alpha = 0
        tileNode.zPosition = 3
        tileNode.run(SKAction.fadeIn(withDuration: 2 * interval))
        boardNode?.addChild(tileNode)
        
        gameModel.addTile(Tile(index: index, number: number, name: tileName))
    }
    
    private func putTile() {
        if let index = gameModel.randomEmptyIndex {
            putTile(index: index, number: gameModel.randomNextNumber)
        }
    }
    
    private func updateTiles() {
        gameModel.deleteTiles.forEach { tile in
            guard let tileNode = boardNode?.getTileNode(withName: tile.name) else { return }
            tileNode.zPosition = 2
            if 0 < tile.move {
                let to = tilePosition(with: tile.index)
                let duration = interval * Double(tile.move)
                let sequence = SKAction.sequence([
                    SKAction.move(to: to, duration: duration),
                    SKAction.removeFromParent()
                ])
                tileNode.run(sequence)
            } else {
                let duration = interval * Double(LINES - 1)
                let sequence = SKAction.sequence([
                    SKAction.wait(forDuration: duration),
                    SKAction.removeFromParent()
                ])
                tileNode.run(sequence)
            }
        }
        gameModel.tiles.forEach { tile in
            guard let tileNode = boardNode?.getTileNode(withName: tile.name) else { return }
            if 0 < tile.move {
                let to = tilePosition(with: tile.index)
                let duration = interval * Double(tile.move)
                tileNode.run(SKAction.move(to: to, duration: duration))
            }
            
            if tileNode.numberNode.text == String(tile.number) { return }
            let numberSequence = SKAction.sequence([
                SKAction.wait(forDuration: interval * Double(LINES - 1)),
                SKAction.fadeOut(withDuration: interval),
                SKAction.run({
                    tileNode.numberNode.text = "\(tile.number)"
                    tileNode.numberNode.fontSize = tileNode.fontSize(from: tile.number)
                    if tile.number == 8 {
                        tileNode.numberNode.fontColor = UIColor.tileFontWhite
                    }
                }),
                SKAction.fadeIn(withDuration: interval)
            ])
            tileNode.numberNode.run(numberSequence)
            
            let tileSequence = SKAction.sequence([
                SKAction.wait(forDuration: interval * Double(LINES - 1)),
                SKAction.run({ tileNode.fillColor = UIColor.tile(number: tile.number) }),
                SKAction.scale(to: 1.2, duration: interval),
                SKAction.scale(to: 1, duration: interval)
            ])
            tileNode.run(tileSequence)
        }
    }
    
    private func updateScore() {
        scoreNode?.updateScore(gameModel.score)
        bestScoreNode?.updateScore(gameModel.bestScore)
    }
    
    private func putGameover() {
        let coverNode = SKShapeNode(rectOf: CGSize(boardSide + borderWidth), cornerRadius: 8)
        coverNode.name = "gameover"
        coverNode.fillColor = UIColor(white: 1, alpha: 0.3)
        coverNode.strokeColor = .clear
        coverNode.position = boardNode!.position
        coverNode.zPosition = 4
        
        let labelNode = SKLabelNode(text: "Gameover!")
        labelNode.fontColor = UIColor.gameover
        labelNode.fontName = UIFont.monospacedSystemFont(ofSize: 1, weight: .bold).fontName
        labelNode.fontSize = 0.5 * tileSide
        labelNode.horizontalAlignmentMode = .center
        labelNode.verticalAlignmentMode = .center
        labelNode.position = .zero
        coverNode.addChild(labelNode)
        
        contentNode?.addChild(coverNode)
    }

}
