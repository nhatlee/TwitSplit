//
//  MessageModel.swift
//  TwitSplit
//
//  Created by nhatlee on 3/1/18.
//  Copyright © 2018 nhatlee. All rights reserved.
//

import Foundation
import MessageKit

struct MessageModel: MessageType {
    var sender: Sender
    var data: MessageData
    var messageId: String
    var sentDate: Date
    
    init(data: MessageData, sender: Sender, messageId: String, date: Date) {
        self.data = data
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
    }
    
    init(text: String, sender: Sender, messageId: String, date: Date) {
        self.init(data: .text(text), sender: sender, messageId: messageId, date: date)
    }
    
    init(attributedText: NSAttributedString, sender: Sender, messageId: String, date: Date) {
        self.init(data: .attributedText(attributedText), sender: sender, messageId: messageId, date: date)
    }
    
    init(image: UIImage, sender: Sender, messageId: String, date: Date) {
        self.init(data: .photo(image), sender: sender, messageId: messageId, date: date)
    }
    
    init(thumbnail: UIImage, sender: Sender, messageId: String, date: Date) {
        let url = URL(fileURLWithPath: "")
        self.init(data: .video(file: url, thumbnail: thumbnail), sender: sender, messageId: messageId, date: date)
    }
    
    init(emoji: String, sender: Sender, messageId: String, date: Date) {
        self.init(data: .emoji(emoji), sender: sender, messageId: messageId, date: date)
    }
    
}
