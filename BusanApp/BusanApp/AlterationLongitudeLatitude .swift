//
//  AlterationLongitudeLatitude .swift
//  BusanApp
//
//  Created by Eunkyo, Seo on 9/28/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation


//

//  AlterationLongitudeAndLatitude.swift

//  BusanApp

//

//  Created by Eunkyo, Seo on 9/28/15.

//  Copyright © 2015 Eunkyo. All rights reserved.

//



import Foundation





struct lamc_parameter {
    
    var Re: Double          /* 사용할 지구반경 [ km ]      */
    
    var grid: Double;        /* 격자간격        [ km ]      */
    
    var slat1: Double;       /* 표준위도        [degree]    */
    
    var slat2: Double;       /* 표준위도        [degree]    */
    
    var olon: Double;        /* 기준점의 경도   [degree]    */
    
    var olat: Double;        /* 기준점의 위도   [degree]    */
    
    var xo: Double;          /* 기준점의 X좌표  [격자거리]  */
    
    var yo: Double;          /* 기준점의 Y좌표  [격자거리]  */
    
    var first: Int;       /* 시작여부 (0 = 시작)         */
    
}







class AlterationLongitudeLatitude {
    
    
    
    
    
    func altbegin(longitude:Double,
        
        latitude:Double) -> (x:Int, y:Int) {
            
            
            
            
            
            var map: lamc_parameter =
            
            lamc_parameter(Re: 0, grid: 0, slat1: 0, slat2: 0, olon: 0, olat: 0, xo: 0, yo: 0, first: 0)
            
            
            
            map.Re = 6371.00877
            
            map.grid = 5.0
            
            map.slat1 = 30.0
            
            map.slat2 = 60.0
            
            map.olon = 126.0
            
            map.olat = 38.0
            
            map.xo = 210/map.grid
            
            map.yo = 675/map.grid
            
            map.first = 0
            
            
            
            
            
            
            
            
            
            let result = map_conv(longitude, latitude: latitude, parameter: map)
            
            
            
            print("x = \(result.x), y = \(result.y)")
            
            
            
            return (result.x , result.y)
            
            
            
            
            
    }
    
    
    
    
    
    
    
    
    
    
    
    func map_conv(longitude:Double,
        
        latitude:Double,
        
        var parameter:lamc_parameter) -> (x:Int, y:Int) {
            
            
            
            var PI: Double = Double()
            
            var DEGRAD: Double = Double()
            
            var RADDEG: Double = Double()
            
            
            
            var re: Double = Double()
            
            var slat1: Double = Double()
            
            var slat2: Double = Double()
            
            var olon: Double = Double()
            
            var olat: Double = Double()
            
            
            
            var sn: Double = Double()
            
            var sf: Double = Double()
            
            var ro: Double = Double()
            
            
            
            if parameter.first == 0 {
                
                PI = asin(1.0) * 2.0
                
                DEGRAD = PI/180.0
                
                RADDEG = 180.0/PI
                
                
                
                re = parameter.Re / parameter.grid
                
                slat1 = parameter.slat1 * DEGRAD
                
                slat2 = parameter.slat2 * DEGRAD
                
                olon = parameter.olon * DEGRAD
                
                olat = parameter.olat * DEGRAD
                
                
                
                sn = tan(PI * 0.25 + slat2 * 0.5) / tan(PI * 0.25 + slat1 * 0.5)
                
                sn = log(cos(slat1) / cos(slat2)) / log(sn)
                
                
                
                sf = tan(PI * 0.25 + slat1 * 0.5)
                
                sf = pow(sf, sn) * cos(slat1) / sn
                
                
                
                ro = tan(PI * 0.25 + olat * 0.5)
                
                ro = re * sf / pow(ro, sn)
                
                parameter.first = 1
                
            }
            
            
            
            var ra = tan(PI * 0.25 + latitude * DEGRAD * 0.5)
            
            ra = re * sf / pow(ra, sn)
            
            
            
            var theta = longitude * DEGRAD - olon
            
            
            
            if theta > PI {
                
                theta -= 2.0 * PI
                
            }
            
            
            
            if theta < -PI {
                
                theta += 2.0 * PI
                
            }
            
            
            
            theta *= sn
            
            
            
            return ((Int)(((ra * sin(theta)) + parameter.xo) + 1.5), (Int)(((ro - ra*cos(theta)) + parameter.yo) + 1.5)
                
            )
            
            
            
            
            
    }
    
    
    
}