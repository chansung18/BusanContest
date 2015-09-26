//
//  MainViewController.swift
//  BusanApp
//
//  Created by chansung on 9/24/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

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
    

    var rainData: [CGFloat] = [15, 13, 5, 20, 9]
    var humidityData: [CGFloat] = [30, 35, 10, 70, 80]
    var windSpeedData: [CGFloat] = [10, 2, 20, 21, 30]
    
    var index = 0
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
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
        
        NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "dataUpdate", userInfo: nil, repeats: true)
        
        
        let pasingtest = WeatherParser()
        pasingtest.beginParsing("1234")
        
        setWeather(pasingtest.getWeatherData())
        

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
        
        if weatherDataFromParser[1].desc == "구름 많음" {
            weatherImage2.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[1].desc == "구름 조금" {
            weatherImage2.image = UIImage(named: "little-cloudy")
        }
        else if weatherDataFromParser[1].desc == "맑음" {
            weatherImage2.image = UIImage(named: "sunshine")
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
        
        if weatherDataFromParser[3].desc == "구름 많음" {
            weatherImage4.image = UIImage(named: "cloudy")
        }
        else if weatherDataFromParser[3].desc == "구름 조금" {
            weatherImage4.image = UIImage(named: "little-cloudy")
        }
        else if weatherDataFromParser[3].desc == "맑음" {
            weatherImage4.image = UIImage(named: "sunshine")
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
        
        
        
        for i in 0...4 {
            rainData[i] = CGFloat(weatherDataFromParser[i].rainExpectationRate)
            humidityData[i] = CGFloat(weatherDataFromParser[i].humidityRate)
            windSpeedData[i] = CGFloat(weatherDataFromParser[i].windSpeed)
        }
        
        graphView.addLine(humidityData)
        graphView.addLine(rainData)
        graphView.addLine(windSpeedData)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
