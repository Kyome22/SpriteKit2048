//
//  TileColor.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/16.
//

import UIKit.UIColor

extension UIColor {
    
    static func tile(number: Int) -> UIColor {
        switch number {
        case 2:    return UIColor(red: 0.93, green: 0.89, blue: 0.86, alpha: 1.0)
        case 4:    return UIColor(red: 0.93, green: 0.88, blue: 0.79, alpha: 1.0)
        case 8:    return UIColor(red: 0.95, green: 0.70, blue: 0.48, alpha: 1.0)
        case 16:   return UIColor(red: 0.96, green: 0.58, blue: 0.39, alpha: 1.0)
        case 32:   return UIColor(red: 0.97, green: 0.49, blue: 0.37, alpha: 1.0)
        case 64:   return UIColor(red: 0.97, green: 0.37, blue: 0.23, alpha: 1.0)
        case 128:  return UIColor(red: 0.93, green: 0.81, blue: 0.45, alpha: 1.0)
        case 256:  return UIColor(red: 0.93, green: 0.80, blue: 0.38, alpha: 1.0)
        case 512:  return UIColor(red: 0.93, green: 0.79, blue: 0.31, alpha: 1.0)
        case 1024: return UIColor(red: 0.93, green: 0.77, blue: 0.25, alpha: 1.0)
        case 2048: return UIColor(red: 0.93, green: 0.76, blue: 0.18, alpha: 1.0)
        default:   return UIColor(red: 0.23, green: 0.23, blue: 0.19, alpha: 1.0)
        }
    }
    
    static let text = UIColor(red: 0.54, green: 0.51, blue: 0.47, alpha: 1.0)
    static let background = UIColor(red: 0.98, green: 0.97, blue: 0.94, alpha: 1.0)
    static let board = UIColor(red: 0.74, green: 0.68, blue: 0.63, alpha: 1.0)
    static let tileBase = UIColor(red: 0.80, green: 0.75, blue: 0.71, alpha: 1.0)
    static let tileFontBlack = UIColor(red: 0.47, green: 0.43, blue: 0.40, alpha: 1.0)
    static let tileFontWhite = UIColor(red: 0.98, green: 0.97, blue: 0.95, alpha: 1.0)
    static let gameover = UIColor(red: 0.47, green: 0.43, blue: 0.40, alpha: 1.0)
    static let newGameBase = UIColor(red: 0.56, green: 0.48, blue: 0.40, alpha: 1.0)
    static let newGameTitle = UIColor(red: 0.98, green: 0.97, blue: 0.94, alpha: 1.0)
    static let scoreBase = UIColor(red: 0.78, green: 0.74, blue: 0.69, alpha: 1.0)
    static let scoreTitle = UIColor(red: 0.98, green: 0.97, blue: 0.94, alpha: 1.0)
    
}
