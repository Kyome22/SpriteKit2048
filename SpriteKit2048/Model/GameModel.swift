//
//  GameModel.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import Foundation

class GameModel {
    
    private let LINES: Int
    public private(set) var score: Int = 0
    public private(set) var tiles = [Tile]()
    public private(set) var deleteTiles = [Tile]()
    
    var bestScore: Int {
        get {
            return DataManager.shared.bestScore
        }
        set {
            DataManager.shared.bestScore = newValue
        }
    }
    
    var randomEmptyIndex: Int? {
        if tiles.count == LINES * LINES { return nil }
        let population = (0 ..< LINES * LINES).compactMap { n in
            return tiles.contains(where: { $0.index == n }) ? nil : n
        }
        return population.randomElement()
    }
    
    var randomNextNumber: Int {
        return 2 * (1 + Int.random(in: 0 ... 9) / 9)
    }
    
    init(LINES: Int) {
        self.LINES = LINES
        self.bestScore = DataManager.shared.bestScore
    }
    
    func reset() {
        tiles.removeAll()
        deleteTiles.removeAll()
        score = 0
    }
    
    func addTile(_ tile: Tile) {
        tiles.append(tile)
    }
    
    func shiftTiles(swipe: SwipeDirection) -> Bool {
        // 移動量を0にリセットする
        tiles.forEach { $0.move = 0 }
        
        // swipeごとにいい感じにソートする
        tiles.sort { a, b in
            switch swipe {
            case .left:
                return a.index < b.index
            case .top:
                let c1 = (a.index % LINES) == (b.index % LINES) && b.index < a.index
                let c2 = (a.index % LINES) < (b.index % LINES)
                return c1 || c2
            case .right:
                return b.index < a.index
            case .bottom:
                let c1 = (a.index % LINES) == (b.index % LINES) && a.index < b.index
                let c2 = (b.index % LINES) < (a.index % LINES)
                return c1 || c2
            }
        }
        
        // 行または列で分解する
        var tilePacks: [[Tile]] = (0 ..< LINES).map { n in
            return tiles.filter { tile in
                switch swipe {
                case .left:   return tile.index / LINES == n
                case .top:    return tile.index % LINES == n
                case .right:  return tile.index / LINES == LINES - n - 1
                case .bottom: return tile.index % LINES == LINES - n - 1
                }
            }
        }
        tiles.removeAll()
        
        // それぞれ隣り合うやつとマージするかどうかの処理をする
        // 次消える子はnumberを0にする
        // tileにindexを振り直す
        // tileの移動量を計算してmoveに入れる
        var moved: Bool = false
        deleteTiles.removeAll()
        for i in (0 ..< LINES) {
            var n: Int = 0
            for j in (0 ..< tilePacks[i].count) {
                switch swipe {
                case .left:
                    let nextIndex = i * LINES + n
                    tilePacks[i][j].move = tilePacks[i][j].index - nextIndex
                    tilePacks[i][j].index = nextIndex
                case .top:
                    let nextIndex = LINES * (LINES - 1 - n) + i
                    tilePacks[i][j].move = (nextIndex - tilePacks[i][j].index) / LINES
                    tilePacks[i][j].index = nextIndex
                case .right:
                    let nextIndex = LINES * (LINES - i) - 1 - n
                    tilePacks[i][j].move = nextIndex - tilePacks[i][j].index
                    tilePacks[i][j].index = nextIndex
                case .bottom:
                    let nextIndex = LINES - i - 1 + n * LINES
                    tilePacks[i][j].move = (tilePacks[i][j].index - nextIndex) / LINES
                    tilePacks[i][j].index = nextIndex
                }
                moved = moved || 0 < tilePacks[i][j].move
                if j < tilePacks[i].count - 1 {
                    if tilePacks[i][j].number == tilePacks[i][j + 1].number {
                        tilePacks[i][j].number *= 2
                        tilePacks[i][j + 1].number = 0
                        score += tilePacks[i][j].number
                    } else {
                        n += 1
                    }
                }
            }
            for j in (0 ..< tilePacks[i].count).reversed() {
                if tilePacks[i][j].number == 0 {
                    deleteTiles.append(tilePacks[i].remove(at: j))
                }
            }
            tiles.append(contentsOf: tilePacks[i])
        }
        bestScore = max(bestScore, score)
        return moved
    }
    
    func judgeGameover() -> Bool {
        // tilesの要素数がマス目一杯に埋まっていなかったらゲームオーバーではない
        if tiles.count < Int(LINES * LINES) { return false }
        // とりあえずソートする
        tiles.sort { $0.index < $1.index }
        for i in (0 ..< LINES) {
            for j in (0 ..< LINES - 1) {
                // 横方向のチェック
                if tiles[LINES * i + j].number == tiles[LINES * i + j + 1].number {
                    return false
                }
                // 縦方向のチェック
                if tiles[i + LINES * j].number == tiles[i + LINES * (j + 1)].number {
                    return false
                }
            }
        }
        return true
    }
    
}

/*
 left
 12 13 14 15
 _8  9 10 11
 _4  5  6  7
 _0  1  2  3
 
 top
 15 11  7  3
 14 10  6  1
 13  9  5  1
 12  8  4  0
 
 right
 _3  2  1  0
 _7  6  5  4
 11 10  9  8
 15 14 13 12
 
 bottom
 _3  7 11 15
 _2  6 10 14
 _1  5  9 13
 _0  4  8 12
 */
