//
//  HackingSwift39Tests.swift
//  HackingSwift39Tests
//
//  Created by Franklin Buitron on 5/13/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import XCTest
@testable import HackingSwift39

class HackingSwift39Tests: XCTestCase {
    var playData: PlayData!
    override func setUp() {
        super.setUp()
        playData = PlayData()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAllWordsLoaded() {
        XCTAssertEqual(playData.allWords.count, 18440, "all words must be 0");
    }
    
    func testWordFrequencies() {
        XCTAssertEqual(playData.wordCounts.count(for:"TOUCHSTONE") , 84, "Home does not appear 84 times")
        XCTAssertEqual(playData.wordCounts.count(for: "fun"), 4, "Fun does not appear 4 times")
        XCTAssertEqual(playData.wordCounts.count(for:"mortal"), 41, "Mortal does not appear 41 times")
    }
    
    func testWordsLoadQuickly() {
        measure {
            _ = PlayData()
        }
    }
    
    func testUserFilterWorks() {
        
        playData.applyUserFilter("100")
        XCTAssertEqual(playData.filteredWords.count, 495)
        
        playData.applyUserFilter("1000")
        XCTAssertEqual(playData.filteredWords.count, 55)
        
        playData.applyUserFilter("10000")
        XCTAssertEqual(playData.filteredWords.count, 1)
        
        playData.applyUserFilter("test")
        XCTAssertEqual(playData.filteredWords.count, 56)
        
        playData.applyUserFilter("swift")
        XCTAssertEqual(playData.filteredWords.count, 7)
        
        playData.applyUserFilter("objective-c")
        XCTAssertEqual(playData.filteredWords.count, 0)
    }
    
}
