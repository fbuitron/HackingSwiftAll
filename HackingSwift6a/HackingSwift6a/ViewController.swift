//
//  ViewController.swift
//  HackingSwift2
//
//  Created by Franklin Buitron on 5/7/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {
    
    var button1: UIButton = UIButton()
    var button2: UIButton = UIButton()
    var button3: UIButton = UIButton()
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.setImage(UIImage(named: countries[0]), for: UIControlState.normal)
        button2.setImage(UIImage(named: countries[1]), for: UIControlState.normal)
        button3.setImage(UIImage(named: countries[2]), for: UIControlState.normal)
        
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        
        button1.layer.borderWidth = 1.0
        button2.layer.borderWidth = 1.0
        button3.layer.borderWidth = 1.0
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        button1.addTarget(self, action: #selector(self.buttonTapped), for: UIControlEvents.touchUpInside)
        button2.addTarget(self, action: #selector(self.buttonTapped), for: UIControlEvents.touchUpInside)
        button3.addTarget(self, action: #selector(self.buttonTapped), for: UIControlEvents.touchUpInside)
        
        
        self.button1.translatesAutoresizingMaskIntoConstraints = false
        self.button2.translatesAutoresizingMaskIntoConstraints = false
        self.button3.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            button1.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
            button1.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20.0),
            button2.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20.0),
            button3.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            button3.bottomAnchor.constraint(greaterThanOrEqualTo: guide.bottomAnchor, constant: -20.0),
            button1.heightAnchor.constraint(equalTo: button2.heightAnchor),
            button1.heightAnchor.constraint(equalTo: button3.heightAnchor)
            ])
        
        
        askQuestion()
    }
    
    func askQuestion(ction: UIAlertAction! = nil) {
        
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: countries) as! [String]
        button1.setImage(UIImage(named: countries[0]), for: UIControlState.normal)
        button2.setImage(UIImage(named: countries[1]), for: UIControlState.normal)
        button3.setImage(UIImage(named: countries[2]), for: UIControlState.normal)
        correctAnswer = GKRandomSource.sharedRandom().nextInt(upperBound: 3)
        
        title = countries[correctAnswer].uppercased()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        var title = ""
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let myText = "Your score is \(score)."
        
        let ac = UIAlertController(title: title, message: myText, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

