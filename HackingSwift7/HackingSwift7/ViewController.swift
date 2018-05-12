//
//  ViewController.swift
//  HackingSwift7
//
//  Created by Franklin Buitron on 5/10/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("HERE?")
        self.tableView.register(PetitionsUITableViewCell.self, forCellReuseIdentifier: "PETITIONS")
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        if let url = URL(string: urlString) {
            if let data = try? String(contentsOf: url) {
                let decoder = JSONDecoder()
                do {
                    let petitsResponse = try decoder.decode(PetitionResponse.self, from: data.data(using: .utf8)!)
                    self.petitions = petitsResponse.results
                    self.tableView.reloadData()
                } catch let error {
                    debugPrint(error)
                }
            }
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PETITIONS", for: indexPath)
        debugPrint("REUSED")
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }


}

