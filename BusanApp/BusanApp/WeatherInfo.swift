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

class WeatherInfo: UIViewController, NSXMLParserDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    
  //  var isDataTagBeingExamined = false
  //  let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad(){
 /*       self.navigationController?.navigationBarHidden = false;
        self.navigationController?.navigationBar.topItem?.title = "방사능"
 
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)*/
        
 //       tableView.dataSource = self
  //      tableView.delegate = self
        
  //      tableView.registerClass(RadioTableViewCell.self, forCellReuseIdentifier: "RadioCell")
        
        
        let weatherparsing = WeatherParser()
        
        weatherparsing.beginParsing("1234")

    }
    
    ///table view delegate
/*    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
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
    }*/
    
//        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -&gt; UITableViewCell {
//            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as PlacesTableViewCell
//            let entry = data.places[indexPath.row]
//            let image = UIImage(named: entry.fil
//        
    ///mapkit helper function
/*    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }*/
    
    

}

