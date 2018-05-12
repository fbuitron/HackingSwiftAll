//
//  DetailViewController.swift
//  HackingSwift7
//
//  Created by Franklin Buitron on 5/11/18.
//  Copyright © 2018 Franklin Buitron. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        view = webView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
