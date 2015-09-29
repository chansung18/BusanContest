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

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    
    var rainData: [CGFloat] = [15, 13, 5, 20, 9]
    var humidityData: [CGFloat] = [30, 35, 10, 70, 80]
    var windSpeedData: [CGFloat] = [10, 2, 20, 21, 30]
    
    var index = 0
    let pasingtest = WeatherParser()
    let radioLocationParser = EnvironmentRadiationParsingLocationInfo()
    let airQualityCompareDistance = AirQualityDistanceInfo()
    let waterQualityParser = WaterParser()
    
    let radioParsing = EnvironmentRadiationParser()
    let airQualityParsing = AirQualityParser()
    let locationManager = CLLocationManager()
    let currentLocationParser = CurrentLocationParser()
    
    var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    var timer: NSTimer?
    
    var averageRadiationDataCurrent = Double()
    var averageRadiationDataBefore = Double()
    
    func radioPointerAnimationWith(value: Double) {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            if 4.5 - (0.45 * value) > 3 {
                self.radioGaugePointer.transform = CGAffineTransformMakeRotation(3)
            }
            
            self.radioGaugePointer.transform = CGAffineTransformMakeRotation(4.5 - CGFloat((0.45 * value)))
        },
        completion: nil)
        loadingActivityIndicator.stopAnimating()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        
        //radiation
        //worst:  0(radian) = 10
        //best: 4.5(radian) = 0
        //0.45 * 0.11
        //4.5 - (0.45 * 0.11)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        highlightView1.layer.cornerRadius = highlightView1.frame.size.width/4.5
        highlightView1.clipsToBounds = true
        
        highlightView2.layer.cornerRadius = highlightView2.frame.size.width/4.5
        highlightView1.clipsToBounds = true
        
        highlightView3.layer.cornerRadius = highlightView3.frame.size.width/4.5
        highlightView1.clipsToBounds = true
        
        loadingActivityIndicator.layer.cornerRadius = loadingActivityIndicator.frame.size.width/4.5
        loadingActivityIndicator.clipsToBounds = true
        
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
            print("location manager starting update location")
        }
        
        graphView.addLine(humidityData)
        graphView.addLine(rainData)
        graphView.addLine(windSpeedData)
    }
    
    //location manager delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("location update occurred : size of locations : \(locations.count)")
        
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        
        loadingActivityIndicator.startAnimating()
        
        if locations.count > 0 {
            if currentLocation.latitude != locations[0].coordinate.latitude ||
                currentLocation.longitude != locations[0].coordinate.longitude {
                    currentLocation = locations[0].coordinate
                    
                    print("latitude = \(currentLocation.latitude)")
                    print("longitude = \(currentLocation.longitude)")
                    
                    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                        if let locationData = self.currentLocationParser.getLocationFrom(locations[0].coordinate.latitude,
                            longitude :locations[0].coordinate.longitude) {
                                
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.provinceLabel.text = locationData.provinceName
                                self.cityLabel.text = "(\(locationData.cityName))"
                            })

                            let getXYFromEarthPoint = AlterationLongitudeLatitude().altbegin(self.currentLocation.longitude, latitude: self.currentLocation.latitude)
                                
                            //weather parsing
                            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                                self.pasingtest.beginParsing(getXYFromEarthPoint.x,urlY: getXYFromEarthPoint.y)
                                
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    self.setWeather(self.pasingtest.getWeatherData())
                                    if self.timer == nil {
                                     self.timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "dataUpdate", userInfo: nil, repeats: true)
                                    }
                                })
                            })
                                
                            //radiation parsing
                            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                                self.radioLocationParser.beginParsing(locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                                
                                for distance in self.radioLocationParser.getDistanceSet() {
                                    let seqNumber = distance.0
        
                                     if (seqNumber != 6)&&(seqNumber != 15)&&(seqNumber != 19)&&(seqNumber != 17)&&(seqNumber < 21){
                                        self.radioParsing.beginParsing(seqNumber)
                                    }
        
                                    if self.radioParsing.dataSet.count > 0 {
                                        print("setNuber----->\(seqNumber)")
                                        break
                                    }
                                }
                                
                                print("size of radio parsing data = \(self.radioParsing.dataSet.count)")
        
                                var radioDataSetSum = 0.0
                                var radioDataSetSumBefore = 0.0
        
                                for radiationData in self.radioParsing.dataSet {
                                    radioDataSetSum += radiationData.currentData
                                    radioDataSetSumBefore += radiationData.oneHourAveData
                                }
                                    
                                print("average data out of 20 items : \(radioDataSetSum/Double(self.radioParsing.dataSet.count))")
                                
                                self.averageRadiationDataCurrent = radioDataSetSum/Double(self.radioParsing.dataSet.count)
                                self.averageRadiationDataBefore = radioDataSetSumBefore/Double(self.radioParsing.dataSet.count)
        
                                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                    self.radioPointerAnimationWith(self.averageRadiationDataCurrent)
                                })
                            })
                              
                            //air pollution parsing
                            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                                self.airQualityCompareDistance.beginCompareLocations(locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
                                
                                for distance in self.airQualityCompareDistance.getDistanceSet() {
                                    let zoneNumber = distance.0
                                    self.airQualityParsing.beginParsing(zoneNumber)
        
        
                                    if self.airQualityParsing.dataSet.count > 0 {
                                        print("setNuber----->\(zoneNumber)")
                                        break
                                    }
                                }
                            })
                                
                            //water pollution parsing
                            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), { () -> Void in
                                print("지역이름  :\(locationData.fullName)")
                                self.waterQualityParser.beginParsing("남구")
                            })
                        }
                    })
            }
        }
    }
    
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
