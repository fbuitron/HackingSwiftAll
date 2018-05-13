//
//  PlayData.swift
//  HackingSwift39
//
//  Created by Franklin Buitron on 5/13/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import Foundation

class PlayData {
    var allWords = [String]()
    var wordCounts: NSCountedSet!
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: ".txt") {
            if let plays = try? String(contentsOfFile: path) {
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                allWords = allWords.filter { $0 != "" }
                wordCounts = NSCountedSet(array: allWords)
                let sorted = wordCounts.allObjects.sorted {
                    wordCounts.count(for: $0) > wordCounts.count(for: $1)
                }
                allWords = sorted as! [String]
            }
        }
    }
}
