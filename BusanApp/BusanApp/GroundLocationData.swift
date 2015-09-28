//
//  GroundLocationData.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/28/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation


func ==(lhs: GroundLocationData, rhs: GroundLocationData) -> Bool{
    
    return lhs.hashValue == rhs.hashValue
    
}

class GroundLocationData: Hashable{
    var longitude: Double
    var latitude: Double
    
    var hashValue: Int{
        return "\(self.longitude),\(self.latitude)".hashValue
    }
    
    init(longitude: Double, latitude: Double)
    {
        self.longitude = latitude
        self.latitude = longitude
    }
    
    

    
    
}