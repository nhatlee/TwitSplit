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
        let result = try! SplitMessage().splitMessage(inputStr)
        XCTAssertEqual(result, expected)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            var inputStr = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
            for i in 0...10000 {
                inputStr += (inputStr + "\(i)")
                let _ = try! SplitMessage().splitMessage(inputStr)
            }
        }
    }
    
}
