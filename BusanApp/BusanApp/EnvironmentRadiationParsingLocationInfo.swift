//
//  EnvironmentRadiationParsingLocationInfo.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/28/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation


class EnvironmentRadiationParsingLocationInfo: NSXMLParserDelegate  {
    
    
    
    let XMLRadiationEachElementStartingTagKey = "item"
    let XMLRadiationEachElementLatitude = "lat"
    let XMLRadiationEachElementlongitude = "lng"
    let XMLRadiationEachElementLocalName = "locNm"
    let XMLRadiationEachElementseq = "seq"
    
    
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var element = NSString()
    
    var isDataTagBeingExamined = false
    var dataTagReadCount = 0
    
    
    var currentRadiationData: EnvironmentRadiationLocationData?
    var dataSet:[EnvironmentRadiationLocationData] = [EnvironmentRadiationLocationData]()
    
    init(let longitude: Double, let latitude: Double){
        
        
        
    }
    func getSeq() -> Int{
        return 1 // 인자값과 경도 위도 비교후 체고가까운곳 seq제공
    }
    func beginParsing(let longitude: Double, let latitude: Double)
    {
        
        
        dataTagReadCount = 0
        
        
        let getEnvironmentalRadiationPlaceListURL = "http://opendata.busan.go.kr/openapi/service/EnvironmentalRadiationInfoService/getEnvironmentalRadiationPlaceList?"
        let serviceKey = "ServiceKey=hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"

        
        let urlInString = "\(getEnvironmentalRadiationPlaceListURL)numOfRows=\(31)&\(serviceKey)"
        
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
        
        if elementName == XMLRadiationEachElementStartingTagKey
        {
            currentRadiationData = EnvironmentRadiationLocationData()
        }
    }
    
    func parser(parser: NSXMLParser,
        foundCharacters string: String) {
            if element == XMLRadiationEachElementlongitude {
                currentRadiationData?.longitude = (NSNumberFormatter().numberFromString(string)?.doubleValue)!
            }
            else if element == XMLRadiationEachElementLatitude{
                currentRadiationData?.latitude = (NSNumberFormatter().numberFromString(string)?.doubleValue)!
            }
            else if element == XMLRadiationEachElementLocalName {
                currentRadiationData?.locationName = string
            }
            else if element == XMLRadiationEachElementseq {
                currentRadiationData?.seq = (NSNumberFormatter().numberFromString(string)?.integerValue)!
            }
    }
    
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?)
    {
        element = ""
        
        if( elementName == XMLRadiationEachElementStartingTagKey ) {
            if let radiationLocationData = currentRadiationData {
                dataSet.append(radiationLocationData)
                print("append" + radiationLocationData.locationName)
            }
            
            dataTagReadCount++
        }
        
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("All examined data count = \(dataTagReadCount)");
        
        for data: EnvironmentRadiationLocationData in dataSet {
            print(data);
        }
    }
}