//
//  ViewController.swift
//  RockLunch iPad
//
//  Created by Jacob Wilson on 4/19/16.
//  Copyright © 2016 Jacob Wilson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    
    @IBAction func button(sender: AnyObject) {
        refreshMenu()
    }
    
    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func refreshMenu() {
        getData()
    }
    
    func getDateParams()->String{
        let final_date: String?
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: date)
        
        let year =  components.year
        let month = components.month
        let day = components.day
        
        final_date = "current_day=\(year)-\(month)-\(day)&adj=3"
        return final_date!;
    }
    
    func getData(){
        
        let p:String! = "<!DOCTYPE html><html lang='en'><head><meta charset='utf-8'/><meta name='viewport' content='width=device-width, initial-scale=1'/><title>Rock Lunch</title> <link href='https://rawgit.com/Jacob1233/RockLunchCSS/master/main.css' rel='stylesheet' type='text/css'><style></style></head><body><div id='content'>"
        
        let q:String = "</div></body></html>"
        
        var l:String = ""
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://myschooldining.com/Rockhurst%20High%20School/calendarWeek")!)
        request.HTTPMethod = "POST"
        let postString = getDateParams()
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {
                //print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {
                // do something error
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding) as String?
            l = responseString!
            
            let fin = p + l + q
            
            self.webview.loadHTMLString(fin, baseURL: nil)
            
        }
        task.resume()
    }


}

