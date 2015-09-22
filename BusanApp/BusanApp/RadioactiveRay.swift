//
//  RadioactiveRay.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/17/15.
//  Copyright (c) 2015 Eunkyo. All rights reserved.
//


import UIKit
import Foundation

class RadioactiveRay: UIViewController, NSXMLParserDelegate {
    
    let XMLWeatherEachElementStartingTagKey = "data"
    let XMLWeatherEachElementHourTagKey = "hour"
    let XMLWeatherEachElementDayTagKey = "day"
    let XMLWeatherEachElementTempTagKey = "temp"
    let XMLWeatherEachElementDescriptionTagKey = "wfKor"
    let XMLWeatherEachElementRainExpectionTagKey = "pop"
    let XMLWeatherEachElementWindDirectionTagKey = "wdEn"
    let XMLWeatherEachElementWindSpeedTagKey = "ws"
    let XMLWeatherEachElementHumidityRateTagKey = "reh"
    
    @IBOutlet weak var tbData: UITableView!
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    var category = String()
    
    var isDataTagBeingExamined = false
    var dataTagReadCount = 0
    
    var currentWeatherData: WeatherData?
    var dataSet:[WeatherData] = [WeatherData]()
    
    override func viewDidLoad(){
        dataTagReadCount = 0
        beginParsing()
    }
    
    func beginParsing()
    {
        
        /* imfo zone
        
        
        */
        
        let urlOfWatherKMA = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?"
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
        
        tbData!.reloadData()
        print("bingParsin1g\n")
    }
    
    //When the parsing process is fully finished.
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
    
    //Tableview Methods
    func tableView(tableView: UITableView,
                    numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell")
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! UITableViewCell;
        }
        
        cell.textLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("title") as! NSString as String
        cell.detailTextLabel?.text = posts.objectAtIndex(indexPath.row).valueForKey("date") as! NSString as String
        
        return cell as UITableViewCell
    }
}

