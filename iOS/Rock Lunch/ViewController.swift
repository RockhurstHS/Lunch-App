//
//  ViewController.swift
//  Rock Lunch
//
//  Created by JacobWilson on 9/29/15.
//  Copyright © 2015 JacobWilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webviewHTML: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL (string: "http://www.aquarii.net/RockLunch/");
        let requestObj = NSURLRequest(URL: url!);
        webviewHTML.scalesPageToFit = true;
        webviewHTML.loadRequest(requestObj);
        
        self.view.backgroundColor = UIColor(red: 1/255, green: 60/255, blue: 162/255, alpha: 1)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
}

