//
//  RadioactiveRay.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/17/15.
//  Copyright (c) 2015 Eunkyo. All rights reserved.
//


import UIKit
import MapKit
import Foundation

class RadioactiveRay: UIViewController, NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let XMLWeatherEachElementStartingTagKey = "data"
    let XMLWeatherEachElementHourTagKey = "hour"
    let XMLWeatherEachElementDayTagKey = "day"
    let XMLWeatherEachElementTempTagKey = "temp"
    let XMLWeatherEachElementDescriptionTagKey = "wfKor"
    let XMLWeatherEachElementRainExpectionTagKey = "pop"
    let XMLWeatherEachElementWindDirectionTagKey = "wdEn"
    let XMLWeatherEachElementWindSpeedTagKey = "ws"
    let XMLWeatherEachElementHumidityRateTagKey = "reh"
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad(){
        self.navigationController?.navigationBarHidden = false;
        self.navigationController?.navigationBar.topItem?.title = "방사능"
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(RadioTableViewCell.self, forCellReuseIdentifier: "RadioCell")
        
        dataTagReadCount = 0
        beginParsing()
    }
    
    ///table view delegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell:RadioTableViewCell = tableView.dequeueReusableCellWithIdentifier("RadioCell", forIndexPath: indexPath) as? RadioTableViewCell {
            print("hellooooooo")
            
            return cell
        }
        
        return UITableViewCell()
    }
    
//        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -&gt; UITableViewCell {
//            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as PlacesTableViewCell
//            let entry = data.places[indexPath.row]
//            let image = UIImage(named: entry.fil
//        
    ///mapkit helper function
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
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
        
//        tbData!.reloadData()
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
}

