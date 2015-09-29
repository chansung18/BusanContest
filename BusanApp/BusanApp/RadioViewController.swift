//
//  RadioViewController.swift
//  BusanApp
//
//  Created by Chansung, Park on 9/26/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RadioViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var mapView: MKMapView!
    
    var radioParser = EnvironmentRadiationParser()
    let regionRadius: CLLocationDistance = 1000
    var locationDataSet : [EnvironmentRadiationLocationData] = [EnvironmentRadiationLocationData]()
    override func viewDidLoad() {
        super.viewDidLoad()        
//        radioParser.beginParsing(2)
        
        let gpsDataParser: EnvironmentRadiationParsingLocationInfo = EnvironmentRadiationParsingLocationInfo()
        gpsDataParser.beginParsing(0.0, longitude: 0.0)
        locationDataSet = gpsDataParser.dataSet
        
        for districData in gpsDataParser.dataSet{
            
            centerMapOnLocation(districData)
           
        }
        
        
        
        
    }

    func centerMapOnLocation(districData: EnvironmentRadiationLocationData) {
        
        
        let location = CLLocationCoordinate2DMake(districData.latitude, districData.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let coordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = districData.locationName
        annotation.subtitle = ("latitude : \(location.latitude) longitude : \(location.longitude)")
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RadioCell")
        return cell!
    }

    
}
