//
//  UserDefault+Setting.swift
//  TwitSplit
//
//  Created by nhatlee on 3/1/18.
//  Copyright © 2018 nhatlee. All rights reserved.
//
import Foundation

extension UserDefaults {
    
    static let messagesKey = "mockMessages"
    
    // MARK: - Mock Messages
    
    func setMockMessages(count: Int) {
        set(count, forKey: "mockMessages")
        synchronize()
    }
    
    func mockMessagesCount() -> Int {
        if let value = object(forKey: "mockMessages") as? Int {
            return value
        }
        return 20
    }
}
