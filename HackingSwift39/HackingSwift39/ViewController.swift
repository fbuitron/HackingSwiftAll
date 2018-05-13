//
//  ViewController.swift
//  HackingSwift39
//
//  Created by Franklin Buitron on 5/13/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var playData = PlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: "SHAKES")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.allWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SHAKES", for: indexPath)
        let word = playData.allWords[indexPath.row]
        cell.textLabel?.text = word
        cell.detailTextLabel?.text = "\(playData.wordCounts.count(for: word))"
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

