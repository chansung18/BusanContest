//
//  EnvrionmentaRadiationInfo.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/19/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit



class EnvironmetRadiationInfo: UIViewController, NSXMLParserDelegate{
    
    
    let XMLRadiationEachElementStartingTagKey = "item"
    let XMLRadiationEachElementCheckTimeTagKey = "checkTime"
    let XMLRadiationEachElementCurrentDataTagKey = "data"
    let XMLRadiationEachElementLocalNameTagKey = "name"
    let XMLRadiationEachElementOneHourAveDataTagKey = "oneHourAveData"
    let XMLRadiationEachElementOnehourAveTimeTagKey = "oneHourAveTime"

    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var element = NSString()
    
    var isDataTagBeingExamined = false
    var dataTagReadCount = 0
    
    
    var currentRadiationData: RadiationData?
    var dataSet:[RadiationData] = [RadiationData]()
    
    
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
        
       let getEnvironmentalRadiationPlaceListURL = "http://opendata.busan.go.kr/openapi/service/EnvironmentalRadiationInfoService/getEnvironmentalRadiationInfoDetail?ServiceKey="
        
        
        let serviceKey = "hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"
        
        
        let url = getEnvironmentalRadiationPlaceListURL + serviceKey
        

        
        
        posts = []
        parser = NSXMLParser(contentsOfURL:(NSURL(string: url)!))!
        parser.delegate = self
        
        parser.parse()
        

        print("-----------url----------\n" + url)
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
            
            if elementName == XMLRadiationEachElementStartingTagKey
            {
                currentRadiationData = RadiationData()
            }
    }
    
    func parser(parser: NSXMLParser,
        foundCharacters string: String) {
            if element == XMLRadiationEachElementCheckTimeTagKey {
                currentRadiationData?.checkTime = string
            }
            else if element == XMLRadiationEachElementCurrentDataTagKey {
                currentRadiationData?.currentData = (NSNumberFormatter().numberFromString(string)?.doubleValue)!
            }
            else if element == XMLRadiationEachElementLocalNameTagKey {
                currentRadiationData?.localName = string
            }
            else if element == XMLRadiationEachElementOneHourAveDataTagKey {
                currentRadiationData?.oneHourAveData = (NSNumberFormatter().numberFromString(string)?.doubleValue)!
            }
            else if element == XMLRadiationEachElementOnehourAveTimeTagKey {
                currentRadiationData?.oneHourAveTime = string
            }
            
            
            
            
     
            
    }

    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?)
    {
        element = ""
        
        if( elementName == XMLRadiationEachElementStartingTagKey ) {
            if let radiationData = currentRadiationData {
                dataSet.append(radiationData)
                print("append" + radiationData.localName)
            }
            
            dataTagReadCount++
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("All examined data count = \(dataTagReadCount)");
        
        for data: RadiationData in dataSet {
            print(data);
        }
    }
    
    
    
    
    
    
    
    
    
    

    
    
}

