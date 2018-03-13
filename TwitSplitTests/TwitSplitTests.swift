//
//  TwitSplitTests.swift
//  TwitSplitTests
//
//  Created by nhatlee on 2/27/18.
//  Copyright © 2018 nhatlee. All rights reserved.
//

import XCTest
@testable import TwitSplit

class TwitSplitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSplitMessage() {
        let inputStr = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking", "2/2 my messages, so I don't have to do it myself."]
        let result = try! SplitMessage.splitMessage(inputStr)
        XCTAssertEqual(result, expected)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let inputStr = """
e. Messages will only be split on whitespace. If the message contains a span of non-whitespace characters longer than 50 characters, display an error.
            f. Split messages will have a "part indicator" appended to the beginning of each section. In the example above, the message was split into two chunks, so the part indicators read "1/2" and "2/2". Be aware that these count toward the character limit.
            2. The functionality that splits messages should be a standalone function. Given the above example, its function call would look like:
            3. The app must be in Swift.
"""
            let _ = try! SplitMessage.splitMessage(inputStr)
        }
    }
    
    func testSplitMessageV2() {
        let inputStr = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let expected = ["1/2 I can't believe Tweeter now supports chunking", "2/2 my messages, so I don't have to do it myself."]
        let result = try! SplitMessage.splitMessageV2(inputStr)
        XCTAssertEqual(result, expected)
    }
    
    func testPerformanceSplitV2() {
        self.measure {
            let inputStr = """
e. Messages will only be split on whitespace. If the message contains a span of non-whitespace characters longer than 50 characters, display an error.
            f. Split messages will have a "part indicator" appended to the beginning of each section. In the example above, the message was split into two chunks, so the part indicators read "1/2" and "2/2". Be aware that these count toward the character limit.
            2. The functionality that splits messages should be a standalone function. Given the above example, its function call would look like:
            3. The app must be in Swift.
"""
            let _ = try! SplitMessage.splitMessageV2(inputStr)
        }
    }
    
}
