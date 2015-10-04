//
//  ViewController.swift
//  Lunch
//
//  Created by jwclark on 9/17/15.
//  Copyright © 2015 jwclark. All rights reserved.
//
//  adapted from http post source code: https://www.youtube.com/watch?v=4YDkJgZCoQs
//  Info.plist config: http://stackoverflow.com/a/32560433/1103584
//
//  icons: http://www.gieson.com/Library/projects/utilities/icon_slayer/#.VgglEqLASas
//
//  language guide: https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309
//
//  myschooldining.com api (just a bread crumb) - http://codepen.io/AJNDL/pen/yhbar
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var webviewHTML: UIWebView!
    
    func extractMenuPagesFromHTML(html: String) {
        let parser = MenuParser(html: html);
        let pages:[MenuPage] = parser.getMenuPages()
    }
    
    //set the view with HTML string
    func updateWebview(var html: String) {
        
        extractMenuPagesFromHTML(html)
        
        html = injectHTML() + html //inject a header of assets like css and scripts

        //load assets in respect to their base URL ('tis why I keep all the site files in the same folder)
        let base = NSBundle.mainBundle().pathForResource("site/main", ofType: "css")!
        let baseUrl = NSURL(fileURLWithPath: base)
        webviewHTML.loadHTMLString(html, baseURL: baseUrl)
    }
    
    //put some html files at the top (like a web page)
    func injectHTML() -> String {
        var header: String = ""
        let assets: [String] = [
            "<link href=\"main.css\" rel=\"stylesheet\"/>",
            "<script src=\"jquery-1.11.3.min.js\"></script>",
            "<script src=\"mod-plugins.js\"></script>",
            "<script src=\"jquery.mobile-1.4.5.min.js\"></script>",
            "<script src=\"moment.min.js\"></script>",
            "<script src=\"main.js\"></script>"
        ]
        for asset in assets {
            header += asset
        }
        return header
    }
    
    //build a data parameter string from today
    func getDateParams() -> String {
        //get today
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day, .Month, .Year], fromDate: date)
        let day = components.day
        let month = components.month
        let year = components.year
        return "current_month=\(year)-\(month)-\(day)&adj=0"
    }
    
    //HTTP POST method
    func post(url : String, params : String, successHandler: (response: String) -> Void) {
        let url = NSURL(string: url)
        let params = String(params);
        let request = NSMutableURLRequest(URL: url!);
        request.HTTPMethod = "POST"
        request.HTTPBody = params.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            //in case of error
            if error != nil {
                return
            }

            let responseString : String = String(data: data!, encoding: NSUTF8StringEncoding)!
            successHandler(response: responseString)
        }
        task.resume();
    }
    
    //the view did load, successfully i suppose
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://myschooldining.com/Rockhurst%20High%20School/calendarMonth"
        post(url, params: getDateParams(), successHandler: {(response) in self.updateWebview(response)});
    }

    //a warning, probably not going to occur in this app - maybe some other apps take up too much memory though (but they'd be serialized to disk, ya?)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

