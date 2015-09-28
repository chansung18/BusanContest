//
//  EnvironmentRadiationParser.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/25/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit

class EnvironmentRadiationParser: UIViewController, NSXMLParserDelegate {
    
    
    
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
    
    
    
    var currentRadiationData: RadiationData?
    var dataSet:[RadiationData] = [RadiationData]()
    
    
    func beginParsing(let urlLocation: Int)
    {
        
        dataTagReadCount = 0
        
        
        let getEnvironmentalRadiationPlaceListURL = "http://opendata.busan.go.kr/openapi/service/EnvironmentalRadiationInfoService/getEnvironmentalRadiationInfoDetail?"
        let serviceKey = "ServiceKey=hUer3lXoCRhuXvM%2FQ%2F8x1nnDNcqCxmKpM1XY9J08dnXW4sgh0wwZYQK0eEohYWtPUQq5mQ7b%2BH9l1QAE%2BAwrbg%3D%3D"
        let seqISDistrictNumber = urlLocation
        
        let urlInString = "\(getEnvironmentalRadiationPlaceListURL)numOfRows=\(10)&seq=\(seqISDistrictNumber)&\(serviceKey)"
        
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