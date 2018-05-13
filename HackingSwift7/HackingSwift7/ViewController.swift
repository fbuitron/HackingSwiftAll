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
        self.tableView.register(PetitionsUITableViewCell.self, forCellReuseIdentifier: "PETITIONS")
        let urlString: String;
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        } else {
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            if let url = URL(string: urlString) {
                if let data = try? String(contentsOf: url) {
                    let decoder = JSONDecoder()
                    do {
                        let petitsResponse = try decoder.decode(PetitionResponse.self, from: data.data(using: .utf8)!)
                        self.petitions = petitsResponse.results
                        DispatchQueue.main.async { [unowned self] in
                            self.tableView.reloadData()
                        }
                    } catch {
                       self.showError()
                    }
                }
            }
        }
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
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dv = DetailViewController()
        dv.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(dv, animated: true)
    }

    func showError() {
        DispatchQueue.main.async { [unowned self] in
            let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }

}

