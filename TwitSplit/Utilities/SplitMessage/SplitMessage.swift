//
//  SplitMessage.swift
//  TwitSplit
//
//  Created by nhatlee on 2/27/18.
//  Copyright © 2018 nhatlee. All rights reserved.
//
import Foundation

let MAXIMUM_CHARACTER_ALLOWED = 50

enum InputError: Error {
    case inputWrong(String)
}

struct SplitMessage {
    static func splitMessage(_ message: String) throws -> [String] {
        // Cache the length of the input because we're going to
        // use it a few times and it's expensive to calculate.
        let countCharacter = message.count
        if countCharacter <= MAXIMUM_CHARACTER_ALLOWED {
            return [message]
        }
        
        let listWordInput = message.components(separatedBy: .whitespacesAndNewlines)
        let countListWord = listWordInput.count
        
        var partsInfo = getPartInfoOfSplit(countCharacter, countListWord - 1)
        
        if countListWord < partsInfo.part {
            throw InputError.inputWrong("Error: Your input message have more than 50 charactes and not contain white spaces")
        }
        var result = [String]()
        
        var appendString = ""
        var counterPart = 1
        var prefixString = partsInfo.prefixString
        
        defer {
            assert(!(appendString.count > MAXIMUM_CHARACTER_ALLOWED), "Split message wrong")
        }
        for (idx, word) in listWordInput.enumerated() {
            let allowCharacter = MAXIMUM_CHARACTER_ALLOWED - (prefixString.count + 1)
            let predictString = appendString + " \(word)"
            if appendString.count >= allowCharacter || predictString.count >= MAXIMUM_CHARACTER_ALLOWED {
                counterPart += 1
                //update prefix string
                prefixString = "\(counterPart)/\(partsInfo.part)"
                result.append(appendString)
                //reset appendString
                appendString = ""
            }
            
            if !appendString.contains(prefixString){
                appendString = prefixString + " \(word)"
            } else {
                appendString = predictString
            }
            
            if idx == countListWord - 1 {
                //if end of the list while character of appendString still < MAXIMUM_CHARACTER_ALLOWED then we still add to the list
                result.append(appendString)
            }
        }
        return result
    }
    
    static func getPartInfoOfSplit(_ messageCount: Int, _ whiteSpaceCount:Int) -> (part: Int, prefixString: String){
        var parts = Int(ceil(Double(messageCount)/Double(MAXIMUM_CHARACTER_ALLOWED)))
        let counterPart = 1
        var prefixString = "\(counterPart)/\(parts)"
        let prefixCount = prefixString.count
        if (prefixCount * parts + whiteSpaceCount) >= MAXIMUM_CHARACTER_ALLOWED {
            let plusPartCount = prefixCount * parts + whiteSpaceCount - MAXIMUM_CHARACTER_ALLOWED
            parts += lround(Double(plusPartCount)/Double(MAXIMUM_CHARACTER_ALLOWED))
            prefixString = "\(counterPart)/\(parts)"
        }
        return (part: parts, prefixString: prefixString)
    }
}
