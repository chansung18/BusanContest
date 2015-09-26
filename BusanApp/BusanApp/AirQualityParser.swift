//
//  DustRatioParser.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/26/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit


class AirQualityParser: UIViewController, NSXMLParserDelegate {
    
    let XMLAirQualityEachElementStartingTagKey = "item"
    let XMLAirQualityEachElementAreaIndex = "areaIndex"
    let XMLAirQualityEachElementCurrentTime = "controInnuber"
    let XMLAirQualityEachElementAmountOfCo = "co"
    let XMLAirQualityEachElementAmountOfNo2 = "no2"
    let XMLAirQualityEachElementAmountOfo3 = "o3"
    let XMLAirQualityEachElementAmountOfPm10 = "pm10"
    let XMLAirQualityEachElementAmountOfPm25 = "pm25"
    let XMLAirQualityEachElementSiteName = "site"
    let XMLAirQualityEachElementAmountOfso2 = "os2"
    
    
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var element = NSString()
    
    var isDataTagBeingExamined = false
    var dataTagReadCount = 0
    
    
    var currentAirQualityData: AirQualityData?
    var dataSet:[AirQualityData] = [AirQualityData]()
    
    
    
    func beginParsing(let urlLocation: String)
    {
        
        dataTagReadCount = 0
        
        
        let getEnvironmentalRadiationPlaceListURL = "http://opendata.busan.go.kr/openapi/service/AirQualityInfoService/getAirQualityInfoClassifiedByStation?"
        let serviceKey = "ServiceKey=hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"
        
        
        let urlInString = "\(getEnvironmentalRadiationPlaceListURL)numOfRows=\(40)&seq=\(urlLocation)&\(serviceKey)"
        
        
        
        
        posts = []
        if let url = NSURL(string: urlInString) {
            parser = NSXMLParser(contentsOfURL:(url))!
        }
        else {
            print("NSURL in NiL")
        }
        
        parser.delegate = self
        
        parser.parse()
        
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
        
        if elementName == XMLAirQualityEachElementStartingTagKey
        {
            currentAirQualityData = AirQualityData()
        }
    }
    
    func parser(parser: NSXMLParser,
        foundCharacters string: String) {
            if element == XMLAirQualityEachElementAreaIndex {
                currentAirQualityData?.areaIndex = string
            }
            else if element == XMLAirQualityEachElementCurrentTime{
                currentAirQualityData?.dateTime = string
            }
            else if element == XMLAirQualityEachElementAmountOfCo {
                currentAirQualityData?.co = string
            }
            else if element == XMLAirQualityEachElementAmountOfNo2 {
                currentAirQualityData?.no2 = string
            }
            else if element == XMLAirQualityEachElementAmountOfo3 {
                currentAirQualityData?.o3 = string
            }
            else if element == XMLAirQualityEachElementAmountOfPm10 {
                currentAirQualityData?.pm10 = string
            }
            else if element == XMLAirQualityEachElementAmountOfPm25 {
                currentAirQualityData?.pm25 = string
            }
            else if element == XMLAirQualityEachElementAmountOfso2 {
                currentAirQualityData?.so2 = string
            }
            else if element == XMLAirQualityEachElementSiteName {
                currentAirQualityData?.site = string
            }
                
                

            
            
    }
    
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?)
    {
        element = ""
        
        if( elementName == XMLAirQualityEachElementStartingTagKey ) {
            if let airQualtyData = currentAirQualityData {
                dataSet.append(airQualtyData)
                print("append" + airQualtyData.site)
            }
            
            dataTagReadCount++
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("All examined data count = \(dataTagReadCount)");
        
        for data: AirQualityData in dataSet {
            print(data);
        }
    }
    
    
    
    
    
    
}
