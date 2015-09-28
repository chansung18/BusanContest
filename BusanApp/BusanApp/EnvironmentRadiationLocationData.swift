//
//  EnvironmentRadiationLocationData.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/28/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation


class EnvironmentRadiationLocationData:  CustomStringConvertible {
    
    
    
    var latitude = 0.0
    var longitude = 0.0
    
    var locationName = ""
    var seq = 0
    
    
    
    
    var description: String {
        get {
            return "[latitude=\(latitude), longitude=\(longitude),locationName=\(locationName) seq=\(seq)";
        }
    }
}