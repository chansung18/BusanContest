//
//  RadiationData.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/19/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation

class RadiationData: CustomStringConvertible{
    
    
    
    var checkTime = ""
    var currentData = 0.0
    var localName = ""
    var oneHourAveData = 0.0
    var oneHourAveTime = ""
    
    
    
    
    
    var description: String {
        get {
            return "[localName=\(localName), checkTime=\(checkTime),currentData=\(currentData), oneHourAveData=\(oneHourAveData), onHourAveTime=\(oneHourAveTime)]";
        }
    }
    
    
    
}
