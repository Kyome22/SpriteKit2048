//
//  Tile.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/12.
//

import SpriteKit

class Tile {
    var index: Int
    var number: Int
    let name: String
    var move: Int
    
    init(index: Int, number: Int, name: String) {
        self.index = index
        self.number = number
        self.name = name
        self.move = 0
    }
}
