//
//  AirQualityViewController.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/29/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//
import UIKit
import MapKit
import CoreLocation

class AirQualityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var groudLocationKey: Dictionary<GroundLocationData, Int> = [
        GroundLocationData(longitude: 35.0998969, latitude: 129.03009210000005): 221112,
        GroundLocationData(longitude: 35.119465, latitude: 129.03545570000006): 221131,
        GroundLocationData(longitude: 35.05307, latitude: 129.08719999999994): 221141,
        GroundLocationData(longitude: 35.157532, latitude: 129.07146799999998): 221152,
        GroundLocationData(longitude: 35.2131199, latitude: 129.06560749999994): 221162,
        GroundLocationData(longitude: 35.2073963, latitude: 129.1018461): 221163,
        GroundLocationData(longitude: 35.1414268, latitude: 129.0932454): 221172,
        GroundLocationData(longitude: 35.1441129, latitude: 128.98728989999995): 221181,
        GroundLocationData(longitude: 35.2121935, latitude: 129.01400869999998): 221182,
        GroundLocationData(longitude: 35.28321, latitude: 129.0661705): 221191,
        GroundLocationData(longitude: 35.1838918, latitude: 129.17639370000006): 221192,
        GroundLocationData(longitude: 35.0768871, latitude: 128.97067500000003): 221202,
        GroundLocationData(longitude: 35.2145209, latitude: 128.98062170000003): 221211,
        GroundLocationData(longitude: 35.1266126, latitude: 128.8586633): 221212,
        GroundLocationData(longitude: 35.1816156, latitude: 129.0882418): 221221,
        GroundLocationData(longitude: 35.2387394, latitude: 129.21581700000002): 221231,
        GroundLocationData(longitude: 35.339239, latitude: 129.17749779999997): 221233,
        GroundLocationData(longitude: 35.1320345, latitude: 129.04007079999997): 221241,
        GroundLocationData(longitude: 35.2303619, latitude: 129.0955619): 221251,
        GroundLocationData(longitude: 35.1595722, latitude: 129.1088482): 221271,
        GroundLocationData(longitude: 35.1795543, latitude: 129.0756416000004): 221281
    ]
    
    let airQualityLocationData: [GroundLocationData] = [
        GroundLocationData(longitude: 35.0998969, latitude: 129.03009210000005),
        GroundLocationData(longitude: 35.119465, latitude: 129.03545570000006),
        GroundLocationData(longitude: 35.05307, latitude: 129.08719999999994),
        GroundLocationData(longitude: 35.157532, latitude: 129.07146799999998),
        GroundLocationData(longitude: 35.2131199, latitude: 129.06560749999994),
        GroundLocationData(longitude: 35.2073963, latitude: 129.1018461),
        GroundLocationData(longitude: 35.1414268, latitude: 129.0932454),
        GroundLocationData(longitude: 35.1441129, latitude: 128.98728989999995),
        GroundLocationData(longitude: 35.2121935, latitude: 129.01400869999998),
        GroundLocationData(longitude: 35.28321, latitude: 129.0661705),
        GroundLocationData(longitude: 35.1838918, latitude: 129.17639370000006),
        GroundLocationData(longitude: 35.0768871, latitude: 128.97067500000003),
        GroundLocationData(longitude: 35.2145209, latitude: 128.98062170000003),
        GroundLocationData(longitude: 35.1266126, latitude: 128.8586633),
        GroundLocationData(longitude: 35.1816156, latitude: 129.0882418),
        GroundLocationData(longitude: 35.2387394, latitude: 129.21581700000002),
        GroundLocationData(longitude: 35.339239, latitude: 129.17749779999997),
        GroundLocationData(longitude: 35.1320345, latitude: 129.04007079999997),
        GroundLocationData(longitude: 35.2303619, latitude: 129.0955619),
        GroundLocationData(longitude: 35.1595722, latitude: 129.1088482),
        GroundLocationData(longitude: 35.1795543, latitude: 129.0756416000004)
    ]
    
    let airQulityParser : AirQualityParser = AirQualityParser()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var radioParser = EnvironmentRadiationParser()
    let regionRadius: CLLocationDistance = 1000
    
    var i = 0
    let numberToLoadAtOnce = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        radioParser.beginParsing(2)
        
        loadingActivityIndicator.startAnimating()
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { () -> Void in
            
            for var index=0; index < self.numberToLoadAtOnce; index++ {
                let gps = self.airQualityLocationData[index]
                let zoneNumber : Int = self.groudLocationKey[gps]!
                self.airQulityParser.beginParsing(zoneNumber)
                self.centerMapOnLocation(gps.latitude ,
                                        longitude: gps.longitude ,
                                        localName: self.airQulityParser.dataSet[self.i].site)
                self.i++
            }
            
//            for gps in self.airQualityLocationData {
//                if( self.i < self.numberToLoadAtOnce ) {
//                    let zoneNumber : Int = self.groudLocationKey[gps]!
//                    self.airQulityParser.beginParsing(zoneNumber)
//                    self.centerMapOnLocation(gps.latitude , longitude: gps.longitude , localName: self.airQulityParser.dataSet[self.i].site)
//                    self.i++
//                }
//            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.loadingActivityIndicator.stopAnimating()
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.reloadData()
            })
            
            print("datazone ->>\(self.airQulityParser.dataSet)")
        }
    }
    
    func centerMapOnLocation(latitude: Double, longitude: Double, localName : String) {
        let location = CLLocationCoordinate2DMake(latitude, longitude)
//        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//        let coordinateRegion = MKCoordinateRegion(center: location, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = localName
//        annotation.subtitle = ("latitude : \(location.latitude) longitude : \(location.longitude)")
//        mapView.setRegion(coordinateRegion, animated: true)
        mapView.addAnnotation(annotation)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airQulityParser.dataSet.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("AirCell") as! AirTableViewCell
        
        cell.placeName.text = airQulityParser.dataSet[indexPath.row].site
        let coValue = NSNumberFormatter().numberFromString(airQulityParser.dataSet[indexPath.row].co)?.doubleValue
        let dustValue = NSNumberFormatter().numberFromString(airQulityParser.dataSet[indexPath.row].pm25)?.doubleValue
        let noValue = NSNumberFormatter().numberFromString(airQulityParser.dataSet[indexPath.row].no2)?.doubleValue
        let ozValue = NSNumberFormatter().numberFromString(airQulityParser.dataSet[indexPath.row].o3)?.doubleValue
        let so2Value = NSNumberFormatter().numberFromString(airQulityParser.dataSet[indexPath.row].so2)?.doubleValue
        let smallDustValue = NSNumberFormatter().numberFromString(airQulityParser.dataSet[indexPath.row].pm10)?.doubleValue
        
        if indexPath.row == i-1 &&
            self.i < self.airQualityLocationData.count{
                self.loadingActivityIndicator.startAnimating()
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                for var index=0; index < self.numberToLoadAtOnce; index++ {
                    
                    if( self.i < self.airQualityLocationData.count ) {
                        let gps = self.airQualityLocationData[self.i]
                        let zoneNumber : Int = self.groudLocationKey[gps]!
                        self.airQulityParser.beginParsing(zoneNumber)
                        self.centerMapOnLocation(gps.latitude , longitude: gps.longitude , localName: self.airQulityParser.dataSet[self.i].site)
                        self.i++
                    }
                }
                
            //    if( self.i < self.airQualityLocationData.count ) {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.loadingActivityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    })
            //    }
            })
        }
        
        if( smallDustValue < 15.0)
        {
           // smallDustStatus.text = "좋음"
            cell.smallDustStatusImage.image = UIImage(named: "greencircle")
        }
        else if( smallDustValue < 55.0)
        {
           // smallDustStatus.text = "보통"
            cell.smallDustStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
           // smallDustStatus.text = "나쁨"
            cell.smallDustStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( coValue < 7.0)
        {
           // coStatus.text = "좋음"
            cell.coStatusImage.image = UIImage(named: "greencircle")
        }
        else if( coValue < 11.0)
        {
           // coStatus.text = "보통"
            cell.coStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
           // coStatus.text = "나쁨"
            cell.coStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( noValue < 0.02)
        {
           // noStatus1.text = "좋음"
            cell.noStatusImage.image = UIImage(named: "greencircle")
        }
        else if( noValue < 0.03)
        {
           // noStatus1.text = "보통"
            cell.noStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
           // noStatus1.text = "나쁨"
            cell.noStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( so2Value < 2.0)
        {
           // so2Status.text = "좋음"
        }
        else if( coValue < 5.0)
        {
           // so2Status.text = "보통"
        }
        else{
           // so2Status.text = "나쁨"
        }
        
        if( ozValue < 0.03)
        {
          //  ozStatus.text = "좋음"
            cell.ozStatusImage.image = UIImage(named: "greencircle")
        }
        else if( ozValue < 0.09)
        {
           // ozStatus.text = "보통"
            cell.ozStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
           // ozStatus.text = "나쁨"
            cell.ozStatusImage.image = UIImage(named: "redcircle")
        }
        
        if( dustValue < 30)
        {
           // dustStatus.text = "좋음"
            cell.dustStatusImage.image = UIImage(named: "greencircle")
        }
        else if( dustValue < 80)
        {
          //  dustStatus.text = "보통"
            cell.dustStatusImage.image = UIImage(named: "yellowcircle")
        }
        else{
           // dustStatus.text = "나쁨"
            cell.dustStatusImage.image = UIImage(named: "redcircle")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let gps = self.airQualityLocationData[indexPath.row]
        let location = CLLocationCoordinate2DMake(gps.latitude, gps.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let coordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
