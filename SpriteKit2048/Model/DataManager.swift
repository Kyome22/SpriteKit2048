//
//  DataManager.swift
//  SpriteKit2048
//
//  Created by Takuto Nakamura on 2021/07/18.
//

import Foundation

fileprivate let RESET_DATA = false

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    
    var bestScore: Int {
        get { return userDefaults.integer(forKey: "bestScore") }
        set { userDefaults.set(newValue, forKey: "bestScore") }
    }

    private init() {
        #if DEBUG
        if RESET_DATA {
            userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        }
        #endif
        userDefaults.register(defaults: ["bestScore": Int(0)])
    }

}
