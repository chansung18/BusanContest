//
//  DustRaito.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/18/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit

class DustRaito: UIViewController, NSXMLParserDelegate{
    
    

    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    override func viewDidLoad() {
        
        beginParsing()
        
    }
    
    func beginParsing()
    {
       var baseUrl = "http://openapi.airkorea.or.kr/openapi/services/rest/MsrstnInfoInqireSvc/getNearbyMsrstnList?tmX=244148.546388&tmY=412423.75772&pageNo=1&numOfRows=10&ServiceKey="
       var serviceKey = "AOzAtUciruP7pIKwP7KO0%2BGWMJV7VWcqhsy1vM0VBuqveoL0sY4GC7s8HGVUXblNGVhsK23WPlqHaWEc8EVrbA%3D%3D"
       var endcodedName = serviceKey.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        
        
        
        
        
        
        
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:serviceKey )!))!
        parser.delegate = self
        
        parser.parse()
        
        
        
    }
    
    
    
}

