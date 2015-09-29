//
//  AirQualityViewController.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/29/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//
import UIKit
import MapKit

class AirQualityViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var radioParser = EnvironmentRadiationParser()
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        radioParser.beginParsing(2)
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RadioCell")
        return cell!
    }
    
    
}
