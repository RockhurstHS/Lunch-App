//
//  ViewController.swift
//  RockLunch iPhone
//
//  Created by Jacob Wilson on 4/18/16.
//  Copyright © 2016 Jacob Wilson. All rights reserved.
//
// https://github.com/davidmfry/IOS-Swift-Basic-Accelerometer-Gyro/blob/master/AccelerometerFun/ViewController.swift
// http://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var currentMaxRotX: Double = 0.0
    var currentMaxRotY: Double = 0.0
    var currentMaxRotZ: Double = 0.0
    
    let motionManager = CMMotionManager()
    
    @IBOutlet weak var webview: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        motionManager.gyroUpdateInterval = 0.2
        
        motionManager.startGyroUpdatesToQueue( NSOperationQueue.currentQueue()!, withHandler: {(gyroData: CMGyroData?, error: NSError?)in
            self.rotationHandler((gyroData?.rotationRate)!)
            if (error != nil)
            {
                // do something error
            }
        })
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func rotationHandler(rotation:CMRotationRate){
        
        if fabs(rotation.x) > fabs(currentMaxRotX) {
            currentMaxRotX = rotation.x
        }
        
        if fabs(rotation.y) > fabs(currentMaxRotY) {
            currentMaxRotY = rotation.y
        }

        if fabs(rotation.z) > fabs(currentMaxRotZ) {
            currentMaxRotZ = rotation.z
        }
        
        if fabs(rotation.y) > 10 {
            getData()
        }
        
    }



}

