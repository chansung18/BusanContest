//
//  EnvrionmentaRadiationInfo.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/19/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit



class WaterQualityInfo: UIViewController, NSXMLParserDelegate{
    
    

    
    
    //    var title1 = NSMutableString()
    //    var date = NSMutableString()
    //    var elements = NSMutableDictionary()
    
    
    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = false;
        self.navigationController?.navigationBar.topItem?.title = "식수질"
        
        
        let parsingTest = WaterParser()
        parsingTest.beginParsing("영도구")
    }
    

}