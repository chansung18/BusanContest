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
    
    var groudLocationKey: Dictionary<GroundLocationData,String> = [
        GroundLocationData(longitude: 35.0998969, latitude: 129.03009210000005): "221112",
        GroundLocationData(longitude: 35.119465, latitude: 129.03545570000006): "221131",
        GroundLocationData(longitude: 35.05307, latitude: 129.08719999999994): "221141",
        GroundLocationData(longitude: 35.157532, latitude: 129.07146799999998): "221152",
        GroundLocationData(longitude: 35.2131199, latitude: 129.06560749999994): "221162",
        GroundLocationData(longitude: 35.2073963, latitude: 129.1018461): "221163",
        GroundLocationData(longitude: 35.1414268, latitude: 129.0932454): "221172",
        GroundLocationData(longitude: 35.1441129, latitude: 128.98728989999995): "221181",
        GroundLocationData(longitude: 35.2121935, latitude: 129.01400869999998): "221182",
        GroundLocationData(longitude: 35.28321, latitude: 129.0661705): "35.2121935",
        GroundLocationData(longitude: 35.1838918, latitude: 129.17639370000006): "221192",
        GroundLocationData(longitude: 35.0768871, latitude: 128.97067500000003): "221202",
        GroundLocationData(longitude: 35.2145209, latitude: 128.98062170000003): "35.0768871",
        GroundLocationData(longitude: 35.1266126, latitude: 128.8586633): "221212",
        GroundLocationData(longitude: 35.1816156, latitude: 129.0882418): "221221",
        GroundLocationData(longitude: 35.2387394, latitude: 129.21581700000002): "221231",
        GroundLocationData(longitude: 35.339239, latitude: 129.17749779999997): "221233",
        GroundLocationData(longitude: 35.1320345, latitude: 129.04007079999997): "221241",
        GroundLocationData(longitude: 35.2303619, latitude: 129.0955619): "221251",
        GroundLocationData(longitude: 35.1595722, latitude: 129.1088482): "221271",
        GroundLocationData(longitude: 35.1795543, latitude: 129.07564160000004): "221281"
    ]
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var element = NSString()
    
    var isDataTagBeingExamined = false
    var dataTagReadCount = 0
    
    
    var currentAirQualityData: AirQualityData?
    var dataSet:[AirQualityData] = [AirQualityData]()
    
    
    
    func beginParsing(let zoneNumber: Int)
    {
        
        dataTagReadCount = 0
        
        let getEnvironmentalRadiationPlaceListURL = "http://opendata.busan.go.kr/openapi/service/AirQualityInfoService/getAirQualityInfoClassifiedByStation?"
        let serviceKey = "ServiceKey=hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"

   
        let urlInString = "\(getEnvironmentalRadiationPlaceListURL)numOfRows=\(5)&idx=\(zoneNumber)&\(serviceKey)"
        
        
        
        
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
