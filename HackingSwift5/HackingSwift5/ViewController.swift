//
//  ViewController.swift
//  HackingSwift5
//
//  Created by Franklin Buitron on 5/8/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import UIKit
import GameplayKit
class ViewController: UITableViewController {
    var allwords = [String]()
    var usedwords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(WordTableViewCell.self, forCellReuseIdentifier: "WORD_CELL")
        if let path = Bundle.main.path(forResource: "start", ofType: "txt") {
            if let startWords = try? String(contentsOfFile: path) {
                allwords = startWords.components(separatedBy: "\n")
            }
        } else {
            allwords = ["silkworm"]
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        startGame()
    }
    
    func startGame () {
        allwords = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: allwords) as! [String]
        title = allwords[0]
        usedwords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
    }
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "submit", style: .default) { [unowned self, ac] _ in
            let answer = ac.textFields![0]
            self.submit(answer: answer.text!)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(answer: String) {
        let lowerAnswer = answer.lowercased()
        do{
            try isPossible(word: lowerAnswer)
            try isOriginal(word: answer)
            try isReal(word: lowerAnswer)
            
            usedwords.insert(answer, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .fade)
            
        } catch ScrambleError.alreadyUsedWord {
            handleErrorFeedback(title: "Already used", message: "\(answer) was already used")
        } catch ScrambleError.invalidWord {
            handleErrorFeedback(title: "Invalid word", message: "\(answer) is not correctly formed from \(String(describing: title))")
        } catch ScrambleError.nonExistantWord {
            handleErrorFeedback(title: "Does not Exists", message: "\(answer) is not a real word")
        } catch {
            handleErrorFeedback(title: "Unexpected error", message: "Something really wrong happened")
        }
    }
    
    func handleErrorFeedback(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) throws  {
        var tempWord = title!.lowercased()

        for letter in word {
            if let pos = tempWord.range(of: String(letter)) {
                tempWord.remove(at: pos.lowerBound)
            } else {
                throw ScrambleError.invalidWord
            }
        }
    }
    
    func isOriginal(word: String) throws {
        if usedwords.contains(word) {
            throw ScrambleError.alreadyUsedWord
        }
    }
    
    func isReal(word: String) throws {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.utf16.count)
        let mispelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        if !(mispelledRange.location == NSNotFound) {
            throw(ScrambleError.nonExistantWord)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WORD_CELL", for: indexPath)
        cell.textLabel?.text = usedwords[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedwords.count
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

enum ScrambleError : Error {
    case invalidWord
    case alreadyUsedWord
    case nonExistantWord
}

