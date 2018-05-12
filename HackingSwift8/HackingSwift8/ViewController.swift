//
//  ViewController.swift
//  HackingSwift8
//
//  Created by Franklin Buitron on 5/12/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

    var twentyButtons =  [String:UIButton]()
    var clearButton: UIButton!
    var submitButton: UIButton!
    var currentAnswer: UITextField!
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var scoreLabel: UILabel!
    
    var answers = [String]() {
        didSet {
            answersLabel.text = answers.joined(separator: "\n")
        }
    }
    
    var activatedButtons = [UIButton]()
    var solutions = [String]()
    
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score) pts"
        }
    }
    var level = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        if twentyButtons.count == 0 {
            for bindex in 0..<20 {
                let button = UIButton(type: .custom)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(36))
                button.tag = 1001
                button.setTitleColor(UIColor.blue, for: .normal)
                button.setTitle("btn\(bindex)", for: UIControlState.normal)
                button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                view.addSubview(button)
                twentyButtons["button\(bindex)"] = button
            }
        }
        
        submitButton = UIButton(type: .custom)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.setTitle("SUBMIT", for: UIControlState.normal)
        submitButton.setTitleColor(UIColor.blue, for: .normal)
        submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        clearButton = UIButton(type: .custom)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.setTitle("CLEAR", for: UIControlState.normal)
        clearButton.setTitleColor(UIColor.blue, for: .normal)
        clearButton.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clearButton)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap Letters To Guess"
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.textAlignment = NSTextAlignment.center
        view.addSubview(currentAnswer)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.textAlignment = NSTextAlignment.center
        cluesLabel.text = "CLUES"
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.textAlignment = NSTextAlignment.center
        answersLabel.text = "ANSWERS"
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        scoreLabel.text = "Score: 0"
        scoreLabel.textAlignment = .right
        view.addSubview(scoreLabel)
        
        setUpConstraints()
        loadLevel()
    }
    
    func setUpConstraints() {
        var baseY = 470
        for buttonIndex in 0..<20 {
            if (buttonIndex  % 5 == 0) {
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(==200)-[button\(buttonIndex)(==120)]", options: [], metrics: nil, views: twentyButtons))
                baseY += buttonIndex > 0 ? 60 : 0
            } else {
                view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[button\(buttonIndex-1)]-(==10)-[button\(buttonIndex)(==120)]", options: [], metrics: nil, views: twentyButtons))
            }
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(==\(baseY))-[button\(buttonIndex)(==60)]", options: [], metrics: nil, views: twentyButtons))
        }
        
        NSLayoutConstraint.activate(
            [
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            submitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 390),
            clearButton.widthAnchor.constraint(equalToConstant: 100),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            clearButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 390),
            currentAnswer.topAnchor.constraint(equalTo: view.topAnchor, constant: 315),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalToConstant: 535),
            currentAnswer.heightAnchor.constraint(equalToConstant: 80),
            cluesLabel.heightAnchor.constraint(equalToConstant: 280),
            cluesLabel.widthAnchor.constraint(equalToConstant: 400),
            cluesLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cluesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 255),
            answersLabel.heightAnchor.constraint(equalToConstant: 280),
            answersLabel.widthAnchor.constraint(equalToConstant: 165),
            answersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            answersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 605),
            scoreLabel.heightAnchor.constraint(equalToConstant: 40),
            scoreLabel.widthAnchor.constraint(equalToConstant: 170),
            scoreLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 830)
                
            ]
        )
    }
    
    @objc func letterTapped(btn: UIButton) {
        currentAnswer.text = currentAnswer.text! + btn.titleLabel!.text!
        activatedButtons.append(btn)
        btn.isHidden = true
    }
    
    @objc func clearTapped(_ sender: Any) {
        currentAnswer.text = ""
        for btn in activatedButtons {
            btn.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    @objc func submitTapped(_ sender: Any) {
        if let solutionPosition = solutions.index(of: currentAnswer.text!) {
            activatedButtons.removeAll()
            debugPrint("answersLabel!.text!\(answersLabel!.text!)")
            answers[solutionPosition] = currentAnswer.text!

            currentAnswer.text = ""
            score += 1
            
            if score % 7 == 0 {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
                present(ac, animated: true)
            }
        }
    }
    
    func loadLevel() {
        var clueString = ""
        var letterBits = [String]()
        if let levelFilePath = Bundle.main.path(forResource: "level\(self.level)", ofType: "txt") {
            if let levelContents = try? String(contentsOfFile: levelFilePath) {
                var lines = levelContents.components(separatedBy: "\n")
                lines = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: lines) as! [String]
                
                for (index, line) in lines.enumerated() {
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString += "\(index + 1). \(clue)\n"
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    answers.append("\(solutionWord.count) letters")
                    solutions.append(solutionWord)
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits += bits

                }
            }
        }
        
        cluesLabel.text = clueString.trimmingCharacters(in: .whitespacesAndNewlines)
        letterBits = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: letterBits) as! [String]
        
        if letterBits.count == twentyButtons.count {
            for i in 0 ..< letterBits.count {
                twentyButtons["button\(i)"]?.setTitle(letterBits[i], for: .normal)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

