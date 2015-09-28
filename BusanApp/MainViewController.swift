//
//  MainViewController.swift
//  BusanApp
//
//  Created by chansung on 9/24/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var graphView: LineChart!
    
    @IBOutlet weak var highlightView1: UIView!
    @IBOutlet weak var highlightView2: UIView!
    @IBOutlet weak var highlightView3: UIView!
    
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel1: UILabel!
    @IBOutlet weak var timeLabel2: UILabel!
    @IBOutlet weak var timeLabel3: UILabel!
    @IBOutlet weak var timeLabel4: UILabel!
    @IBOutlet weak var timeLabel5: UILabel!
    
    
    @IBOutlet weak var tempData1: UILabel!
    @IBOutlet weak var tempData2: UILabel!
    @IBOutlet weak var tempData3: UILabel!
    @IBOutlet weak var tempData4: UILabel!
    @IBOutlet weak var tempData5: UILabel!
    
    @IBOutlet weak var weatherImage1: UIImageView!
    @IBOutlet weak var weatherImage2: UIImageView!
    @IBOutlet weak var weatherImage3: UIImageView!
    @IBOutlet weak var weatherImage4: UIImageView!
    @IBOutlet weak var weatherImage5: UIImageView!
    
    @IBOutlet weak var radioGaugePointer: UIButton!
    @IBOutlet weak var airGaugePointer: UIButton!
    @IBOutlet weak var waterGaugePointer: UIButton!
    
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    var rainData: [CGFloat] = [15, 13, 5, 20, 9]
    var humidityData: [CGFloat] = [30, 35, 10, 70, 80]
    var windSpeedData: [CGFloat] = [10, 2, 20, 21, 30]
    
    var index = 0
    let pasingtest = WeatherParser()
    let radioLocationParser = EnvironmentRadiationParsingLocationInfo()
    let airQualityCompareDistance = AirQualityDistanceInfo()
    
    let radioParsing = EnvironmentRadiationParser()
    let airQualityParsing = AirQualityParser()
    let locationManager = CLLocationManager()
    let currentLocationParser = CurrentLocationParser()
    
    var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var timer: NSTimer?
    
    var averageRadiationDataCurrent = Double()
    var averageRadiationDataBefore = Double()
    
    func degreesToRadians(angle: Double) -> CGFloat {
        return CGFloat((angle / 180.0 * M_PI))
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        locationManager.startUpdatingLocation()
        
        //radiation
        //0 = -145
        //10 = 145
        //29 * 0.11
        //145 - (29 * 0.11)
//     
//        UIView.animateWithDuration(0.5) { () -> Void in
//            self.radioGaugePointer.transform = CGAffineTransformMakeRotation(self.degreesToRadians(180))
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        highlightView1.layer.cornerRadius = highlightView1.frame.size.width/4.5
        highlightView1.clipsToBounds = true
        
        highlightView2.layer.cornerRadius = highlightView2.frame.size.width/4.5
        highlightView1.clipsToBounds = true
        
        highlightView3.layer.cornerRadius = highlightView3.frame.size.width/4.5
        
        highlightView1.clipsToBounds = true
        
        graphView.x.grid.visible = false
        graphView.y.grid.visible = false
        graphView.x.labels.visible = false
        graphView.y.labels.visible = false
        graphView.x.axis.visible = false;
        graphView.y.axis.visible = false;
        
        graphView.backgroundColor = UIColor.clearColor()
        
        // Do any additional setup after loading the view.
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
            locationManager.startUpdatingLocation()
//            locationManager.startMonitoringSignificantLocationChanges()
            print("location manager starting update location")
        }
        
        graphView.addLine(humidityData)
        graphView.addLine(rainData)
        graphView.addLine(windSpeedData)
    }
    
    //location manager delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location update occurred : size of locations : \(locations.count)")

        if locations.count > 0 {
            if currentLocation.latitude != locations[0].coordinate.latitude ||
                currentLocation.longitude != locations[0].coordinate.longitude {
                    currentLocation = locations[0].coordinate
                    
                    print("latitude = \(currentLocation.latitude)")
                    print("longitude = \(currentLocation.longitude)")
                    
                    if let locationData = currentLocationParser.getLocationFrom(locations[0].coordinate.latitude, longitude
                        : locations[0].coordinate.longitude) {
                        provinceLabel.text = locationData.provinceName
                        cityLabel.text = "(\(locationData.cityName))"
                            
                        let getXYFromEarthPoint = AlterationLongitudeLatitude().altbegin(currentLocation.longitude, latitude: currentLocation.latitude)
                            print("x -> \(getXYFromEarthPoint.x) y -> \(getXYFromEarthPoint.y)")
                            
                        pasingtest.beginParsing(getXYFromEarthPoint.x,urlY: getXYFromEarthPoint.y)
                        
                        setWeather(pasingtest.getWeatherData())
                        
                        if timer == nil {
                         timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "dataUpdate", userInfo: nil, repeats: true)   
                        }
                            
                        radioLocationParser.beginParsing(locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                            
                        for distance in radioLocationParser.getDistanceSet() {
                            let seqNumber = distance.0
                            
                             if (seqNumber != 6)&&(seqNumber != 15)&&(seqNumber != 19)&&(seqNumber != 17)&&(seqNumber < 21){
                                radioParsing.beginParsing(seqNumber)
                            }
                            
                            if radioParsing.dataSet.count > 0 {
                                print("setNuber----->\(seqNumber)")
                                break
                            }
                        }
                            
                        print("size of radio parsing data = \(radioParsing.dataSet.count)")
                            
                        var radioDataSetSum = 0.0
                        var radioDataSetSumBefore = 0.0
                            
                        for radiationData in radioParsing.dataSet {
                            radioDataSetSum += radiationData.currentData
                            radioDataSetSumBefore += radiationData.oneHourAveData
                        }
                            
                        print("average data out of 20 items : \(radioDataSetSum/Double(radioParsing.dataSet.count))")
                            
                        averageRadiationDataCurrent = radioDataSetSum/Double(radioParsing.dataSet.count)
                        averageRadiationDataBefore = radioDataSetSumBefore/Double(radioParsing.dataSet.count)
                        
//                        145 - (29 * dataValue)
                        let radioDataAve = radioDataSetSum/Double(radioParsing.dataSet.count)
                        UIView.animateWithDuration(2, animations: { () -> Void in
                            self.radioGaugePointer.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / CGFloat((145 - (29 * radioDataAve))))
                        })
                            
                        airQualityCompareDistance.beginCompareLocations(locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                            
                        for distance in airQualityCompareDistance.getDistanceSet() {
                            let zoneNumber = distance.0
                            airQualityParsing.beginParsing(zoneNumber)
                            
                                
                            if airQualityParsing.dataSet.count > 0 {
                                print("setNuber----->\(zoneNumber)")
                                break
                            }
                        }
                            
                        locationManager.stopUpdatingLocation()
                    }
                    else {
                        //default location data must be filled up.
                        provinceLabel.text = "부산광역시"
                        cityLabel.text = "(서면)"
                    }
            }
        }
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
//        print("location update to new ... occurred : size of locations")
//        
//        print("old location's latitude:\(oldLocation.coordinate.latitude), longitude:\(oldLocation.coordinate.longitude)")
//        print("new location's latitude:\(newLocation.coordinate.latitude), longitude:\(newLocation.coordinate.longitude)")
//    }
    
    //
    
    func dataUpdate() {
        graphView.highlightDataPoints(index)
        
        rainLabel.text = "\(Int(rainData[index]))%"
        humidityLabel.text = "\(Int(humidityData[index]))%"
        windLabel.text = "\(Int(windSpeedData[index]))m/s"
        
        index++;
        if( index >= 5 ) {
            index = 0
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setWeather(let weatherDataFromParser: [WeatherData]){
        
        var isFirstHourPm = false
        
        timeLabel1.text = NSString(format: "%02d", weatherDataFromParser[0].hour) as String
        tempData1.text = ("\(weatherDataFromParser[0].temperature)°C")
        
        if weatherDataFromParser[0].hour > 12  {
            timeLabel1.text?.appendContentsOf("pm")
            isFirstHourPm = true
        } else {
            timeLabel1.text?.appendContentsOf("am")
        }
        
        timeLabel2.text = NSString(format: "%02d", weatherDataFromParser[1].hour) as String
        tempData2.text = ("\(weatherDataFromParser[1].temperature)°C")
        
        if isFirstHourPm {
            if weatherDataFromParser[1].hour > 0 {
                timeLabel2.text?.appendContentsOf("am")
                isFirstHourPm = false
            }
        }
        else {
            if weatherDataFromParser[1].hour > 12 {
                timeLabel2.text?.appendContentsOf("pm")
                isFirstHourPm = true
            }
        }
        
        timeLabel3.text = NSString(format: "%02d", weatherDataFromParser[2].hour) as String
        tempData3.text = ("\(weatherDataFromParser[2].temperature)°C")
        
        if isFirstHourPm {
            if weatherDataFromParser[2].hour > 0 {
                timeLabel3.text?.appendContentsOf("am")
                isFirstHourPm = false
            }
        }
        else {
            if weatherDataFromParser[2].hour > 12 {
                timeLabel3.text?.appendContentsOf("pm")
                isFirstHourPm = true
            }
        }
        
        timeLabel4.text = NSString(format: "%02d", weatherDataFromParser[3].hour) as String
        tempData4.text = ("\(weatherDataFromParser[3].temperature)°C")
        
        if isFirstHourPm {
            if weatherDataFromParser[3].hour > 0 {
                timeLabel4.text?.appendContentsOf("am")
                isFirstHourPm = false
            }
        }
        else {
            if weatherDataFromParser[3].hour > 12 {
                timeLabel4.text?.appendContentsOf("pm")
                isFirstHourPm = true
            }
        }
        
        timeLabel5.text = NSString(format: "%02d", weatherDataFromParser[4].hour) as String
        tempData5.text = ("\(weatherDataFromParser[4].temperature)°C")
        
        if isFirstHourPm {
            if weatherDataFromParser[4].hour > 0 {
                timeLabel5.text?.appendContentsOf("am")
                isFirstHourPm = false
            }
        }
        else {
            if weatherDataFromParser[4].hour > 12 {
                timeLabel5.text?.appendContentsOf("pm")
                isFirstHourPm = true
            }
        }
        
        if weatherDataFromParser[0].desc == "구름 많음" {
            weatherImage1.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[0].desc == "구름 조금" {
            weatherImage1.image = UIImage(named: "little-cloudy")
        }
        else if weatherDataFromParser[0].desc == "맑음" {
            weatherImage1.image = UIImage(named: "sunshine")
        }
        else if weatherDataFromParser[0].desc == "흐림" {
            weatherImage1.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[0].desc == "비" {
            weatherImage1.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[0].desc == "눈/비" {
            weatherImage1.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[0].desc == "눈" {
            weatherImage1.image = UIImage(named: "snow")
        }
        
        
        if weatherDataFromParser[1].desc == "구름 많음" {
            weatherImage2.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[1].desc == "구름 조금" {
            weatherImage2.image = UIImage(named: "little-cloudy")
        }
        else if weatherDataFromParser[1].desc == "맑음" {
            weatherImage2.image = UIImage(named: "sunshine")
        }
        else if weatherDataFromParser[1].desc == "흐림" {
            weatherImage2.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[1].desc == "비" {
            weatherImage2.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[1].desc == "눈/비" {
            weatherImage2.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[1].desc == "눈" {
            weatherImage2.image = UIImage(named: "snow")
        }
        
        
        if weatherDataFromParser[2].desc == "구름 많음" {
            weatherImage3.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[2].desc == "구름 조금" {
            weatherImage3.image = UIImage(named: "little-cloudy")
        }
        else if weatherDataFromParser[2].desc == "맑음" {
            weatherImage3.image = UIImage(named: "sunshine")
        }
        else if weatherDataFromParser[2].desc == "흐림" {
            weatherImage3.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[2].desc == "비" {
            weatherImage3.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[2].desc == "눈/비" {
            weatherImage3.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[2].desc == "눈" {
            weatherImage3.image = UIImage(named: "snow")
        }
        
        
        if weatherDataFromParser[3].desc == "구름 많음" {
            weatherImage4.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[3].desc == "구름 조금" {
            weatherImage4.image = UIImage(named: "little-cloudy")
        }
        else if weatherDataFromParser[3].desc == "맑음" {
            weatherImage4.image = UIImage(named: "sunshine")
        }
        else if weatherDataFromParser[3].desc == "흐림" {
            weatherImage4.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[3].desc == "비" {
            weatherImage4.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[3].desc == "눈/비" {
            weatherImage4.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[3].desc == "눈" {
            weatherImage4.image = UIImage(named: "snow")
        }
        
        
        if weatherDataFromParser[4].desc == "구름 많음" {
            weatherImage5.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[4].desc == "구름 조금" {
            weatherImage5.image = UIImage(named: "little-cloudy")
        }
        else if weatherDataFromParser[4].desc == "맑음" {
            weatherImage5.image = UIImage(named: "sunshine")
        }
        else if weatherDataFromParser[4].desc == "흐림" {
            weatherImage5.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[4].desc == "비" {
            weatherImage5.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[4].desc == "눈/비" {
            weatherImage5.image = UIImage(named: "rain")
        }
        else if weatherDataFromParser[4].desc == "눈" {
            weatherImage5.image = UIImage(named: "snow")
        }
        
        
        
        for i in 0...4 {
            rainData[i] = CGFloat(weatherDataFromParser[i].rainExpectationRate)
            humidityData[i] = CGFloat(weatherDataFromParser[i].humidityRate)
            windSpeedData[i] = CGFloat(weatherDataFromParser[i].windSpeed)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
        if segue.identifier == "RadioSegue" {
            if let destinationViewController = segue.destinationViewController as? RadioPageViewController {
                destinationViewController.areaFullName = "\(provinceLabel.text!) \(cityLabel.text!)"
                destinationViewController.averageRadiationDataCurrent = averageRadiationDataCurrent
                destinationViewController.averageRadiationDataBefore = averageRadiationDataBefore
            }
        }
    }
}
