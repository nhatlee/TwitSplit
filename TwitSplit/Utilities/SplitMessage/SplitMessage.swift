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
    //for v2
    static func findWhiteSpaceIndex(_ inputString: String, allowCharacterCount: Int) -> String.Index? {
        if inputString.count <= allowCharacterCount { return nil}
        var allowCharacter = allowCharacterCount
        var stringAtIndex = "expexted a white space"
        var index: String.Index!
        repeat{
            index = inputString.index(inputString.startIndex, offsetBy: allowCharacter)
            stringAtIndex = String(inputString[index])
            allowCharacter -= 1
        } while (stringAtIndex != " " && allowCharacter > 0)
        assert(stringAtIndex == " ", "wrong")
        return index
    }
}

extension SplitMessage {
    //try another solution
    static func splitMessageV2(_ message: String) throws -> [String] {
        let countCharacter = message.count
        if countCharacter <= MAXIMUM_CHARACTER_ALLOWED {
            return [message]
        }
        let listWordInput = message.components(separatedBy: .whitespacesAndNewlines)
        let countListWord = listWordInput.count
        
        let partsInfo = getPartInfoOfSplit(countCharacter, countListWord - 1)
        
        if countListWord < partsInfo.part {
            throw InputError.inputWrong("Error: Your input message have more than 50 charactes and not contain white spaces")
        }
        var result = [String]()
        
        let allowCharacter = MAXIMUM_CHARACTER_ALLOWED - (partsInfo.prefixString.count + 1)//1: white space
        
        var newString = message
        var counterPart = 1
        var prefixString = partsInfo.prefixString
        repeat{
            if let index = findWhiteSpaceIndex(newString, allowCharacterCount: allowCharacter){
                let subString = newString[newString.startIndex..<index]
                let messageSplit = prefixString + " " + String(subString)
                result.append(messageSplit)
                newString = String(newString[subString.endIndex...].dropFirst())//remove first white space
                counterPart += 1
                //update prefix string
                prefixString = "\(counterPart)/\(partsInfo.part)"
            } else {
                result.append(prefixString + " " + newString)
                break
            }
        } while newString.count > 0
        return result
        
    }
    
    
    static func splitMessage(_ message: String) throws -> [String] {
        // Cache the length of the input because we're going to
        // use it a few times and it's expensive to calculate.
        let countCharacter = message.count
        if countCharacter <= MAXIMUM_CHARACTER_ALLOWED {
            return [message]
        }
        
        let listWordInput = message.components(separatedBy: .whitespacesAndNewlines)
        let countListWord = listWordInput.count
        
        let partsInfo = getPartInfoOfSplit(countCharacter, countListWord - 1)
        
        if countListWord < partsInfo.part {
            throw InputError.inputWrong("Error: Your input message have more than 50 charactes and not contain white spaces")
        }
        var result = [String]()
        
        var appendString = ""
        var counterPart = 1
        var prefixString = partsInfo.prefixString
        
        for (idx, word) in listWordInput.enumerated() {
            let allowCharacter = MAXIMUM_CHARACTER_ALLOWED - (prefixString.count + 1)
            appendString = append(string: appendString, word: word, prefix: prefixString) { _ in appendString.count == 0 }
            let isEnd = idx == (countListWord - 1)
            if isReachLimit(appendString, allowCharacter) || isEnd {
                assert(!(appendString.count > MAXIMUM_CHARACTER_ALLOWED), "Split message wrong")
                result.append(appendString)
                
                counterPart += 1
                //update prefix string
                prefixString = "\(counterPart)/\(partsInfo.part)"
                //reset appendString
                appendString = ""
            }
        }
        return result
    }
    
    static func isReachLimit(_ string: String, _ allowedNo: Int) -> Bool {
        return string.count >= allowedNo
    }
    
    static func append(string: String, word: String, prefix: String, _ predicate:(String) -> Bool) -> String {
        func added(_ fist: String, _ second: String) -> String { return fist + " " + second }
        return predicate(string) ? added(prefix, word) : added(string, word)
    }
}
