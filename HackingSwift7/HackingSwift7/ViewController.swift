//
//  ViewController.swift
//  HackingSwift7
//
//  Created by Franklin Buitron on 5/10/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("HERE?")
        self.tableView.register(PetitionsUITableViewCell.self, forCellReuseIdentifier: "PETITIONS")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PETITIONS") {
            cell.textLabel?.text = petitions[indexPath.row]
            cell.detailTextLabel?.text = "Subtitle"
            return cell
        }
        let cell = PetitionsUITableViewCell(style: .subtitle, reuseIdentifier: "PETITIONS")
        cell.textLabel?.text = petitions[indexPath.row]
        cell.detailTextLabel?.text = "Subtitle"
        return cell
        
    }


}

