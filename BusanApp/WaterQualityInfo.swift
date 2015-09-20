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
    
    
    //    var title1 = NSMutableString()
    //    var date = NSMutableString()
    //    var elements = NSMutableDictionary()
    
    
    override func viewDidLoad(){
        print("ViewDidLoda\n")
        dataTagReadCount = 0
        beginParsing()
    }
    
    func beginParsing()
    {
        for i in 1 ... 47{
            if i<10{
                XMLWaterEachElementChemicalElementsTagKey.append("water0\(i)")
            }
            else{
                
                XMLWaterEachElementChemicalElementsTagKey.append("water0\(i)")
                
            }
        }
        
        let getDrinkableWaterAreaURL = "http://opendata.busan.go.kr/openapi/service/DrinkableWaterQualityInfoService/getDrinkableWaterQualityInfo?numOfRows=50&inspecArea="
        let getUnDrinkableWaterAreaURL = "http://opendata.busan.go.kr/openapi/service/DrinkableWaterQualityInfoService/getUndrinkableWaterInfo?inspecArea="
        let serviceKey = "&ServiceKey=hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"
        
        var queryOfInspecArea = "영도구"
            
        let url = "\(getDrinkableWaterAreaURL)\(queryOfInspecArea)\(serviceKey)"
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string: url)!))!
        parser.delegate = self
        parser.parse()
        print("-----------url----------\n" + url)
            
            
            
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
            /*else{
    
                // let tmepElement = XMLWaterEachElementChemicalElementsTagKey..
                if  XMLWaterEachElementChemicalElementsTagKey.contains(element as String){
                    currentWaterData?.chemicalElements.append(string)
                    print("\(element) = \(string)")
                    
                }
                
            }*/
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