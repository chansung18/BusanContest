//
//  LocationData.swift
//  BusanApp
//
//  Created by Chansung, Park on 9/26/15.
//  Copyright © 2015 Eunkyo. All rights reserved.
//

import Foundation

class LocationData {
    var type = String()
    var code = String()
    var name = String()
    var fullName = String()
    
    var countryName = String()
    
    var provinceCode = String()
    var provinceName = String()
    
    var cityCode = String()
    var cityName = String()
    
    var streetCode = String()
    var streetName = String()
}

/*
type	string	행정동(H)/법정동(B) 구분
code	string	통계청에서 발급되는 행정동 코드
name	string	행정동 명칭
fullName	string	전체 주소
name0	string	국가 이름
code1	string	도 코드
name1	string	도 이름
code2	string	시/구 코드
name2	string	시/구 이름
code3	string	동 코드
name3	string	동 이름
x	float	경도 좌표 (WGS84)
y	float	위도 좌표 (WGS84)
*/