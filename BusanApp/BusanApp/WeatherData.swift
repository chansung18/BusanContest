//
//  WeatherData.swift
//  BusanApp
//
//  Created by chansung on 9/18/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation

class WeatherData: CustomStringConvertible {
    var hour = 0
    var day = 0
    
    var temperature = 0
    
    var rainExpectationRate = 0
    
    var desc = ""
    
    var windDirection = ""
    var windSpeed: Double = 0
    
    var humidityRate = 0
    
    var description: String {
        get {
            return "[day=\(day), hour=\(hour), temp=\(temperature), rainExpectionRate=\(rainExpectationRate), desc=\(desc), windDirection=\(windDirection), windSpeed=\(windSpeed), humidityRate=\(humidityRate)]";
        }
    }
}