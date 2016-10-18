//
//  MenuParser.swift
//  Lunch
//
//  Created by jwclark on 9/27/15.
//  Copyright © 2015 jwclark. All rights reserved.
//
//  should probably use a proper HTML parser - ugh
//  Hpple - https://github.com/topfunky/hpple
//  NDHpple - https://github.com/ndavon/NDHpple
//  Kanna - https://github.com/tid-kijyun/Kanna
//

import Foundation

class MenuParser {
    
    fileprivate var items = [MenuPage]() //new array of MenuPage objects
    
    init(html: String) {
        parseHTMLtoMenuPages(html)
    }
    
    func getMenuPages() -> [MenuPage] {
        return items
    }
    
    fileprivate func parseHTMLtoMenuPages(_ html: String) {
        // build the items array here by going through all the HTML lines
        let array = html.characters.split(separator: "\n") //split before injecting header
        
        /*
        let str = String(array[100])
        print(str)
        if str.containsString("<div class='day-") {
            print("okay")
        }
        */

        for i in 0...array.count-1 {
            let s = String(array[i])
            if s.contains("<div class='day-") {
                print(s)
            }
        }
    }
}
