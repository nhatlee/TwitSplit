//
//  SampleData.swift
//  TwitSplit
//
//  Created by nhatlee on 3/1/18.
//  Copyright © 2018 nhatlee. All rights reserved.
//

import Foundation
import MessageKit

final class SampleData {
    
    static let shared = SampleData()
    
    private init() {}
    
    let messageTextValues = [
        "Ok",
        "Why you have my photo?",
        "lol",
        "1-800-555-0000",
        "One Infinite Loop Cupertino"
    ]
    
    let dan = Sender(id: "123456", displayName: "Dan Leonard")
    let steven = Sender(id: "654321", displayName: "Steven")
    let jobs = Sender(id: "000001", displayName: "Steve Jobs")
    let nhat = Sender(id: "656361", displayName: "Nhat Le")
    
    lazy var senders = [dan, steven, jobs, nhat]
    
    var currentSender: Sender {
        return nhat
    }
    
    let messageImages: [UIImage] = [#imageLiteral(resourceName: "DaLat"), #imageLiteral(resourceName: "nhatle"), #imageLiteral(resourceName: "Steve-Jobs")]
    
    var now = Date()
    
    let messageTypes = ["Text", "Text", "Text", "AttributedText", "Photo", "Emoji"]
    
    let attributes = ["Font1", "Font2", "Font3", "Font4", "Color", "Combo"]
    
    let emojis = [
        "👍",
        "👋",
        "👋👋👋",
        "😱😱",
        "🎈",
        "🇧🇷"
    ]
    
    func attributedString(with text: String) -> NSAttributedString {
        let nsString = NSString(string: text)
        var mutableAttributedString = NSMutableAttributedString(string: text)
        let randomAttribute = Int(arc4random_uniform(UInt32(attributes.count)))
        let range = NSRange(location: 0, length: nsString.length)
        
        switch attributes[randomAttribute] {
        case "Font1":
            mutableAttributedString.addAttribute(NSAttributedStringKey.font, value: UIFont.preferredFont(forTextStyle: .body), range: range)
        case "Font2":
            mutableAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: range)
        case "Font3":
            mutableAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Font4":
            mutableAttributedString.addAttributes([NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: range)
        case "Color":
            mutableAttributedString.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: range)
        case "Combo":
            let msg9String = "Use .attributedText() to add bold, italic, colored text and more..."
            let msg9Text = NSString(string: msg9String)
            let msg9AttributedText = NSMutableAttributedString(string: String(msg9Text))
            
            msg9AttributedText.addAttribute(NSAttributedStringKey.font, value: UIFont.preferredFont(forTextStyle: .body), range: NSRange(location: 0, length: msg9Text.length))
            msg9AttributedText.addAttributes([NSAttributedStringKey.font: UIFont.monospacedDigitSystemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.bold)], range: msg9Text.range(of: ".attributedText()"))
            msg9AttributedText.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "bold"))
            msg9AttributedText.addAttributes([NSAttributedStringKey.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)], range: msg9Text.range(of: "italic"))
            msg9AttributedText.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: msg9Text.range(of: "colored"))
            mutableAttributedString = msg9AttributedText
        default:
            fatalError("Unrecognized attribute for mock message")
        }
        
        return NSAttributedString(attributedString: mutableAttributedString)
    }
    
    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        if randomNumber % 2 == 0 {
            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: now)!
            now = date
            return date
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: now)!
            now = date
            return date
        }
    }
    
    func randomMessage() -> MessageModel {
        
        let randomNumberSender = Int(arc4random_uniform(UInt32(senders.count)))
        let randomNumberText = Int(arc4random_uniform(UInt32(messageTextValues.count)))
        let randomNumberImage = Int(arc4random_uniform(UInt32(messageImages.count)))
        let randomMessageType = Int(arc4random_uniform(UInt32(messageTypes.count)))
        let randomNumberEmoji = Int(arc4random_uniform(UInt32(emojis.count)))
        let uniqueID = NSUUID().uuidString
        let sender = senders[randomNumberSender]
        let date = dateAddingRandomTime()
        
        switch messageTypes[randomMessageType] {
        case "Text":
            return MessageModel(text: messageTextValues[randomNumberText], sender: sender, messageId: uniqueID, date: date)
        case "AttributedText":
            let attributedText = attributedString(with: messageTextValues[randomNumberText])
            return MessageModel(attributedText: attributedText, sender: senders[randomNumberSender], messageId: uniqueID, date: date)
        case "Photo":
            let image = messageImages[randomNumberImage]
            return MessageModel(image: image, sender: sender, messageId: uniqueID, date: date)
        case "Emoji":
            return MessageModel(emoji: emojis[randomNumberEmoji], sender: sender, messageId: uniqueID, date: date)
        default:
            fatalError("Unrecognized mock message type")
        }
    }
    
    func getMessages(count: Int, completion: ([MessageModel]) -> Void) {
        var messages: [MessageModel] = []
        for _ in 0..<count {
            messages.append(randomMessage())
        }
        completion(messages)
    }
    
    func getAvatarFor(sender: Sender) -> Avatar {
        switch sender {
        case dan:
            return Avatar(image: #imageLiteral(resourceName: "DaLat"), initials: "DL")
        case steven:
            return Avatar(initials: "S")
        case jobs:
            return Avatar(image: #imageLiteral(resourceName: "Steve-Jobs"), initials: "SJ")
        case nhat:
            return Avatar(image: #imageLiteral(resourceName: "nhatle"))
        default:
            return Avatar()
        }
    }
    
}
