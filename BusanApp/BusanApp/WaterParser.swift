//
//  WaterPaser.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/25/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit


class WaterParser: UIViewController, NSXMLParserDelegate{
    
    
    
    let XMLWaterEachElementStartingTagKey = "item"
    let XMLWaterEachElementInspecAreaTagKey = "inspecArea"
    let XMLWaterEachElementInspecPointTagKey = "inspecPoint"
    let XMLWaterEachElementResultTagKey = "result"
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var element = NSString()
    
    var isDataTagBeingExamined = false
    var dataTagReadCount = 0
    
    
    var currentWaterData: WaterData?
    var dataSet:[WaterData] = [WaterData]()
    var XMLWaterEachElementChemicalElementsTagKey = [String]()
    
    
    
    func beginParsing(let quertLocation: String)
    {
        
        dataTagReadCount = 0
        for i in 1 ... 47{
            if i<10{
                XMLWaterEachElementChemicalElementsTagKey.append("water0\(i)")
            }
            else{
                
                XMLWaterEachElementChemicalElementsTagKey.append("water\(i)")
                
            }
        }
        
        let getDrinkableWaterAreaURL = "http://opendata.busan.go.kr/openapi/service/DrinkableWaterQualityInfoService/getDrinkableWaterQualityInfo"
        //        let getUnDrinkableWaterAreaURL = "http://opendata.busan.go.kr/openapi/service/DrinkableWaterQualityInfoService/getUndrinkableWaterInfo?inspecArea="
        let serviceKey = "hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"
        
        let queryOfInspecArea = "영도구".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        let urlInString = "\(getDrinkableWaterAreaURL)?numOfRows=\(100)&gu=\(queryOfInspecArea)&ServiceKey=\(serviceKey)"
        
        //        "http://opendata.busan.go.kr/openapi/service/DrinkableWaterQualityInfoService/getDrinkableWaterQualityInfo?numOfRows=50&inspecArea=영도구&ServiceKey=hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"
        
        
        
        
        posts = []
        
        print("url = \(urlInString)")
        
        if let url = NSURL(string: urlInString) {
            parser = NSXMLParser(contentsOfURL:(url))!
        }
        else {
            print("NSURL is NIL")
        }
        
        //        parser = NSXMLParser(contentsOfURL:(NSURL(string: url)!))!
        
        parser.delegate = self
        parser.parse()
        
        /*  url = getUnDrinkableWaterAreaURL + serviceKey
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string: url)!))!
        parser.delegate = self
        parser.parse()
        print("-----------url----------\n" + url)*/
        
    }
    
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("parserStart")
    }
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
        print("eeror")
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
        print("errorrrrr")
    }
    
    
    
    func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String])
    {
        element = elementName
        
        if elementName == XMLWaterEachElementStartingTagKey
        {
            currentWaterData = WaterData()
        }
    }
    
    
    func parser(parser: NSXMLParser,
        foundCharacters string: String) {
            if element == XMLWaterEachElementInspecAreaTagKey {
                currentWaterData?.inspecArea = string
            }
            else if element == XMLWaterEachElementInspecPointTagKey {
                currentWaterData?.inspecPoint = string
            }
            else if element == XMLWaterEachElementResultTagKey{
                currentWaterData?.result = string
            }
            else{
                
                // let tmepElement = XMLWaterEachElementChemicalElementsTagKey..
                if  XMLWaterEachElementChemicalElementsTagKey.contains(element as String){
                    currentWaterData?.chemicalElements.append(string)
                    print("\(element) = \(string)")
                    
                }
                
            }
    }
    
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?)
    {
        element = ""
        
        if( elementName == XMLWaterEachElementStartingTagKey ) {
            if let waterData = currentWaterData {
                dataSet.append(waterData)
                
            }
            
            dataTagReadCount++
        }
        
    }
    func parserDidEndDocument(parser: NSXMLParser) {
        print("All examined data count = \(dataTagReadCount)");
        
        for data: WaterData in dataSet {
            print(data);
        }
    }
    
    
    
    
    
    
}