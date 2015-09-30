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

class RadioViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var radioParser = EnvironmentRadiationParser()
    let regionRadius: CLLocationDistance = 1000
    var locationDataSet : [EnvironmentRadiationLocationData] = [EnvironmentRadiationLocationData]()
    var ridioDataSet: [RadiationData] = [RadiationData]()
    var gpsDataParser: EnvironmentRadiationParsingLocationInfo = EnvironmentRadiationParsingLocationInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()        
//        radioParser.beginParsing(2)
        
        loadingActivityIndicator.startAnimating()
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { () -> Void in
            self.gpsDataParser.beginParsing(0.0, longitude: 0.0)
            self.locationDataSet = self.gpsDataParser.dataSet
            
            for districData in self.gpsDataParser.dataSet{
                self.centerMapOnLocation(districData)
                self.radioParser.beginParsing(districData.seq)
            }
            
            self.ridioDataSet = self.radioParser.dataSet
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.loadingActivityIndicator.stopAnimating()
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.reloadData()
            })
        }
    }

    func centerMapOnLocation(districData: EnvironmentRadiationLocationData) {
        let location = CLLocationCoordinate2DMake(districData.latitude, districData.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let coordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = districData.locationName
//        annotation.subtitle = ("latitude : \(location.latitude) longitude : \(location.longitude)")
//        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ridioDataSet.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : RadioTableViewCell = tableView.dequeueReusableCellWithIdentifier("RadioCell") as! RadioTableViewCell
        
        print("index -- > \(indexPath)   localName -> \(ridioDataSet[indexPath.row].localName)")
        cell.detailTextLabel?.text = ridioDataSet[indexPath.row].localName

        cell.locationName.text = ridioDataSet[indexPath.row].localName
        cell.currentLabel.text = "\(ridioDataSet[indexPath.row].currentData)"
        cell.beforeLabel.text = "\(ridioDataSet[indexPath.row].oneHourAveData)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let districData = self.gpsDataParser.dataSet[indexPath.row]
        let location = CLLocationCoordinate2DMake(districData.latitude, districData.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let coordinateRegion = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(coordinateRegion, animated: true)

//        self.gpsDataParser.dataSet[indexPath.row]
    }
}
