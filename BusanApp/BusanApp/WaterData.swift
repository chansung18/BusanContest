//
//  WaterData.swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/19/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation

class WaterData: CustomStringConvertible {
   
    
    
    var inspecArea = ""
    var inspecPoint = ""
    
    var result = ""
    var chemicalElements = [String]()
    
    
    
    
    var description: String {
        get {
            return "[inspecArea=\(inspecArea), inspecPoint=\(inspecPoint),result=\(result) arry=\(chemicalElements)";
        }
    }
}