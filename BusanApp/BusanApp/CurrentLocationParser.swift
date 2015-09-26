//
//  CurrentLocationParser.swift
//  BusanApp
//
//  Created by Chansung, Park on 9/26/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentLocationParser: NSObject, NSXMLParserDelegate {
    let XMLWeatherEachElementResultingTagKey = "rcode"
    let XMLWeatherEachElementTypeTagKey = "type"
    let XMLWeatherEachElementCodeTagKey = "code"
    let XMLWeatherEachElementNameTagKey = "name"
    let XMLWeatherEachElementFullNameTagKey = "fullName"
    let XMLWeatherEachElementCountryNameTagKey = "name0"
    let XMLWeatherEachElementProvinceCodeTagKey = "code1"
    let XMLWeatherEachElementProvinceNameTagKey = "name1"
    let XMLWeatherEachElementCityCodeTagKey = "code2"
    let XMLWeatherEachElementCityNameTagKey = "name2"
    let XMLWeatherEachElementStreetCodeTagKey = "code3"
    let XMLWeatherEachElementStreetNameTagKey = "name3"
    
    let baseLocalApiCallURL = "https://apis.daum.net/local/geo/coord2addr?apikey=3de8ab2c4cd31333e34c697cbf799a0b&inputCoordSystem=WGS84&output=xml"
    var parser = NSXMLParser()
    var element = String()
    //&longitude=127.10863694633468&latitude=37.40209529907863"
    
    var locationData: LocationData?
    
    func getLocationFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> LocationData? {
        var apiURL = baseLocalApiCallURL
        apiURL.appendContentsOf("&latitude=" + String(latitude))
        apiURL.appendContentsOf("&longitude=" + String(longitude))
        
        print("location url : \(apiURL)")
        
        if let url = NSURL(string: apiURL) {
            parser = NSXMLParser(contentsOfURL:(url))!
        }
        else {
            print("NSURL is not valid")
        }

        parser.delegate = self
        parser.parse()
        
        return locationData
    }
    
    func parserDidStartDocument(parser: NSXMLParser) {
        print("did start parsing for location api")
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("did end parsing for location api")
    }

    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if element == "message" {
            print("message =\(string)")
        }
 
    }

    //When every tags are encountered.
    func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String]) {
        print("element name: \(elementName)")
            
        element = elementName
            
        if elementName == XMLWeatherEachElementResultingTagKey {
            locationData = LocationData()
            
            for attribute in attributeDict.keys {
                if attribute == XMLWeatherEachElementTypeTagKey {
                    locationData?.type = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementCodeTagKey {
                    locationData?.code = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementNameTagKey {
                    locationData?.name = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementFullNameTagKey {
                    locationData?.fullName = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementCountryNameTagKey {
                    locationData?.countryName = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementProvinceCodeTagKey {
                    locationData?.provinceCode = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementProvinceNameTagKey {
                    locationData?.provinceName = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementCityCodeTagKey {
                    locationData?.cityCode = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementCityNameTagKey {
                    locationData?.cityName = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementStreetCodeTagKey {
                    locationData?.streetCode = attributeDict[attribute]!
                }
                else if attribute == XMLWeatherEachElementStreetNameTagKey {
                    locationData?.streetName = attributeDict[attribute]!
                }
            }
        }
            
        if elementName == "error" {
            locationData = Optional.None
            print("error occurred")
        }
    }

    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?) {
            
    }
}

//
//class CurrentLocationParser: NSObjectProtocol, NSXMLParserDelegate {
//    //https://apis.daum.net/local/geo/coord2addr?apikey=3de8ab2c4cd31333e34c697cbf799a0b&longitude=127.10863694633468&latitude=37.40209529907863&inputCoordSystem=WGS84&output=xml
//
//    func parserDidEndDocument(parser: NSXMLParser) {
//    }
//    
//    func parser(parser: NSXMLParser, foundCharacters string: String) {
//    }
//    
//    //When every tags are encountered.
//    func parser(parser: NSXMLParser,
//        didStartElement elementName: String,
//        namespaceURI: String?,
//        qualifiedName qName: String?,
//        attributes attributeDict: [String : String]) {
//   
//    }
//    
//    func parser(parser: NSXMLParser,
//        didEndElement elementName: String,
//        namespaceURI: String?,
//        qualifiedName qName: String?) {
//    }
//}