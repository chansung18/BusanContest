//
//  File.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/25/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit


class WeatherParser: UIViewController, NSXMLParserDelegate {
    
    let XMLWeatherEachElementStartingTagKey = "data"
    let XMLWeatherEachElementHourTagKey = "hour"
    let XMLWeatherEachElementDayTagKey = "day"
    let XMLWeatherEachElementTempTagKey = "temp"
    let XMLWeatherEachElementDescriptionTagKey = "wfKor"
    let XMLWeatherEachElementRainExpectionTagKey = "pop"
    let XMLWeatherEachElementWindDirectionTagKey = "wdEn"
    let XMLWeatherEachElementWindSpeedTagKey = "ws"
    let XMLWeatherEachElementHumidityRateTagKey = "reh"
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()

    

    var dataTagReadCount = 0
    
    var currentWeatherData: WeatherData?
    var dataSet:[WeatherData] = [WeatherData]()
    
    
    

    
    
    func beginParsing(let urlzone: String)
    {
        
        dataTagReadCount = 0
        
        let urlOfWatherKMA = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?"
        
        //let zone = urlzone
        let zone = "4825054000"
        let urlInString = "\(urlOfWatherKMA)zone=\(zone)"
        

        
        posts = []
        
        if let url = NSURL(string: urlInString) {
            parser = NSXMLParser(contentsOfURL:(url))!
        }
        else {
            print("NSURL is NIL")
        }
        
        
        parser.delegate = self
        
        parser.parse()
        
        print("bingParsin1g\n")
       
        
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
        print("All examined data count = \(dataTagReadCount)");
        
        for data: WeatherData in dataSet {
            print(data);
        }
    }
    
    func parser(parser: NSXMLParser,
        foundCharacters string: String) {
            if element == XMLWeatherEachElementHourTagKey {
                currentWeatherData?.hour = (NSNumberFormatter().numberFromString(string)?.integerValue)!
            }
            else if element == XMLWeatherEachElementDayTagKey {
                currentWeatherData?.day = (NSNumberFormatter().numberFromString(string)?.integerValue)!
            }
            else if element == XMLWeatherEachElementTempTagKey {
                currentWeatherData?.temperature = (NSNumberFormatter().numberFromString(string)?.integerValue)!
            }
            else if element == XMLWeatherEachElementDescriptionTagKey {
                currentWeatherData?.desc = string
            }
            else if element == XMLWeatherEachElementRainExpectionTagKey {
                currentWeatherData?.rainExpectationRate = (NSNumberFormatter().numberFromString(string)?.integerValue)!
            }
            else if element == XMLWeatherEachElementWindDirectionTagKey {
                currentWeatherData?.windDirection = string
            }
            else if element == XMLWeatherEachElementWindSpeedTagKey {
                currentWeatherData?.windSpeed = (NSNumberFormatter().numberFromString(string)?.doubleValue)!
            }
            else if element == XMLWeatherEachElementHumidityRateTagKey {
                currentWeatherData?.humidityRate = (NSNumberFormatter().numberFromString(string)?.integerValue)!
            }
            
    }
    
    //When every tags are encountered.
    func parser(parser: NSXMLParser,
        didStartElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?,
        attributes attributeDict: [String : String]) {
            element = elementName
            
            if elementName == XMLWeatherEachElementStartingTagKey {
                currentWeatherData = WeatherData()
            }
    }
    
    func parser(parser: NSXMLParser,
        didEndElement elementName: String,
        namespaceURI: String?,
        qualifiedName qName: String?)
    {
        element = ""
        
        if( elementName == XMLWeatherEachElementStartingTagKey ) {
            if let weatherData = currentWeatherData {
                dataSet.append(weatherData)
            }
            
            dataTagReadCount++
        }
        
    }
    
    
    
    
    
    
}