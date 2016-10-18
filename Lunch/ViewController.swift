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
    
    //set the view with HTML string
    func updateWebview(_ html: String) {
        
        let internalHtml = assembleHTML(html) //inject a header of assets like css and scripts
        
        //load assets in respect to their base URL ('tis why I keep all the site files in the same folder)
        let base = Bundle.main.path(forResource: "site/main", ofType: "css")!
        let baseUrl = URL(fileURLWithPath: base)
        webviewHTML.loadHTMLString(internalHtml, baseURL: baseUrl)
    }
    
    //put some html files at the top (like a web page)
    func assembleHTML(_ html: String) -> String {
        let fileMgr = FileManager.default
        let hPath = Bundle.main.path(forResource: "site/header", ofType: "html")!
        let fPath = Bundle.main.path(forResource: "site/footer", ofType: "html")!
        var hContent: String?
        var fContent: String?
        if fileMgr.fileExists(atPath: hPath) && fileMgr.fileExists(atPath: fPath) {
            do {
                hContent = try String(contentsOfFile: hPath, encoding: String.Encoding.utf8)
                fContent = try String(contentsOfFile: fPath, encoding: String.Encoding.utf8)
            } catch let error as NSError {
                print("error:\(error)")
            }
        } else {
            print("not found")
        }
        let internalHtml = hContent! + html + fContent!
        return internalHtml;
    }
    
    //build a data parameter string from today
    func getDateParams() -> String {
        //get today
        let date = Date()
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components([.day, .month, .year], from: date)
        let day = components.day
        let month = components.month
        let year = components.year
        //The link below is used to get the date to use for getting the html data for showing the lunch.
        //http://myschooldining.com/RockhurstHighSchool/calendarWeek?current_day=2016-09-01&adj=0
        return "current_day=\(year!)-\(month!)-\(day!)&adj=0"
    }
    
    //HTTP POST method
    func post(_ url : String, params : String, successHandler: @escaping (_ response: String) -> Void) {
        let url = URL(string: url)
        let params = String(params);
        var request = URLRequest(url: url!);
        request.httpMethod = "POST"
        request.httpBody = params?.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //in case of error
            if error != nil {
                return
            }
            
            let responseString : String = String(data: data!, encoding: String.Encoding.utf8)!
            successHandler(responseString)
        }
        task.resume();
    }
    
    //the view did load, successfully i suppose
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://myschooldining.com/RockhurstHighSchool/calendarWeek"
        post(url, params: getDateParams(), successHandler: {(response) in self.updateWebview(response)});
    }
    
    //a warning, probably not going to occur in this app - maybe some other apps take up too much memory though (but they'd be serialized to disk, ya?)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

