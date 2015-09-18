//
//  DustRaito.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/18/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit

class DustRaito: UIViewController, NSXMLParserDelegate {
    
    

    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    override func viewDidLoad() {
        
        print("????")
        
        beginParsing()
        
    }
    
    func beginParsing()
    {
        //http://kosis.kr/kosisapi/service/IndicatorService/IndListSearchRequest?STAT_JIPYO_NM=%EA%B0%95%EC%88%98%EB%9F%89&ServiceKey=
        let baseUrl = "http://kosis.kr/kosisapi/service/IndicatorService/IndListSearchRequest?STAT_JIPYO_NM=%EA%B0%95%EC%88%98%EB%9F%89&ServiceKey="
        let serviceKey = "AOzAtUciruP7pIKwP7KO0%2BGWMJV7VWcqhsy1vM0VBuqveoL0sY4GC7s8HGVUXblNGVhsK23WPlqHaWEc8EVrbA%3D%3D"
        
        let url = baseUrl + serviceKey
        
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string:url)!))!
        parser.delegate = self
        
        parser.parse()
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("hello world")
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print("eeror")
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("errorrrrr")
    }
}

