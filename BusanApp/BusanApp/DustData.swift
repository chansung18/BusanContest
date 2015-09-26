//
//  DustData.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/26/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//
import Foundation

class DustData: CustomStringConvertible {
    
    
    
    var areaIndex = ""
    var co = ""
    var dateTime = ""
    var no2 = ""
    var o3 = ""
    var pm10 = ""
    var pm25 = ""
    var site = ""
    var so2 = ""
    
    
    
    
    
    var description: String {
        get {
            return "[areaIndex=\(areaIndex), dataTime=\(dateTime),co=\(co) no2=\(no2), o3=\(o3), pm10=\(pm10), pm25=\(pm25), site=\(site), so2=\(so2)";
        }
    }
}