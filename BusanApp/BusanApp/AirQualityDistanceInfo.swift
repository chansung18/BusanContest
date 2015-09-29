//
//  AirQualityDistanceInfo.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/28/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class AirQualityDistanceInfo: UIViewController, NSXMLParserDelegate{
    
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
    
    var longitude = 0.0
    var latitude = 0.0
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
    
    
    var excludingSeqNumberSet:[Int] = []
    
    
    var distanceSet:[(Int,Double)] = [(Int,Double)]()
    var inputLocation: CLLocationCoordinate2D?
    var selectedSeqNumber = Int()
    var selectedLocation: CLLocationCoordinate2D?
    var selectedDistance: Double = 9999999999999

    
    
    
    func addExcludingSeqNumber(zoneNumber: Int) {
        excludingSeqNumberSet.append(zoneNumber)
        selectedDistance = 9999999999999
    }
    
    
    
    func getLocationCode() -> String {
        
        return "Location"
    }
    
    func getDistanceSet() -> [(Int,Double)] {
        return distanceSet.sort() {
            return $0.1 < $1.1
        }
    }
    
    
    func beginCompareLocations(let latitude: Double, let longitude: Double)
    {
        inputLocation = CLLocationCoordinate2D()
        inputLocation?.longitude = longitude
        inputLocation?.latitude = latitude
        
        if selectedLocation == nil {
            selectedLocation = CLLocationCoordinate2D()
        }
        
        for i in 0 ... airQualityLocationData.count-1
        {
            selectedLocation?.latitude = airQualityLocationData[i].latitude
            selectedLocation?.longitude = airQualityLocationData[i].longitude
            
            let tmpInputLocation = CLLocation(latitude: inputLocation!.latitude, longitude: inputLocation!.longitude)
            
    
            print("timep---> \(airQualityLocationData[i].longitude)")
            
            
            let tmpSelectedLocation = CLLocation(latitude: selectedLocation!.latitude, longitude: selectedLocation!.longitude)            
            print("timep2---> \(tmpSelectedLocation)")
            
            if tmpInputLocation.distanceFromLocation(tmpSelectedLocation) < selectedDistance {
                selectedDistance = tmpInputLocation.distanceFromLocation(tmpSelectedLocation)
                selectedSeqNumber = groudLocationKey[airQualityLocationData[i]]!
                distanceSet.append((groudLocationKey[airQualityLocationData[i]]!, tmpInputLocation.distanceFromLocation(tmpSelectedLocation)))
                print("selceteNumber --->  \(selectedSeqNumber)")
            }

            
        }
        
    }
    
    
    
    
}