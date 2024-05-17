//
//  WeatherModel.swift
//  downloadFiles
//
//  Created by Tejashree on 24/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//

import UIKit

struct WeatherModel {

    var clouds : Float!
    var lat : NSNumber!
    var lon : NSNumber!
    var cityId : Int!
    var humidity : Int!
    var pressure : NSNumber!
    var temp : NSNumber!
    var temp_max : NSNumber!
    var temp_min : NSNumber!
    var name : String!
    var country : String!
    var countryId : Int!
    var visibility : Int!
    var weather : WeatherDesc!
    var weatherIcon : String!
    var windDegree : NSNumber!
    var windSpeed : NSNumber!
    
    init(res:NSDictionary) {
         clouds = (((res.object(forKey: "clouds") as! NSDictionary).object(forKey: "all") ?? Float(0.0) ) as! Float) ?? 0
        lat =
            (((res.object(forKey: "coord") as! NSDictionary).object(forKey: "lat") ?? 0 )as! NSNumber)
        lon = (((res.object(forKey: "coord") as! NSDictionary).object(forKey: "lon") ?? 0 ) as! NSNumber)
        cityId = (res.object(forKey: "id") as! Int)
        humidity = (((res.object(forKey: "main") as! NSDictionary).object(forKey: "humidity") ?? 0 ) as! Int)
        pressure = (((res.object(forKey: "main") as! NSDictionary).object(forKey: "pressure") ?? 0 ) as! NSNumber)
        temp = ((res.object(forKey: "main") as! NSDictionary).object(forKey: "temp") as! NSNumber)
        temp_max = ((res.object(forKey: "main") as! NSDictionary).object(forKey: "temp_max") as! NSNumber)
        temp_min = ((res.object(forKey: "main") as! NSDictionary).object(forKey: "temp_min") as! NSNumber)
        name = (res.object(forKey: "name") as! String)
        country = ((res.object(forKey: "sys") as! NSDictionary).object(forKey: "country") as! String)
        countryId = (((res.object(forKey: "sys") as! NSDictionary).object(forKey: "id") ?? 0 ) as! Int)
        visibility = ((res.object(forKey: "visibility") ?? 0 ) as! Int)
        weather = WeatherDesc(weather: (res.object(forKey: "weather") as! Array)[0] as NSDictionary)        
        windDegree = (((res.object(forKey: "wind") as! NSDictionary).object(forKey: "deg") ?? 0) as! NSNumber)
        windSpeed = (((res.object(forKey: "wind") as! NSDictionary).object(forKey: "speed") ?? 0) as! NSNumber)
    }
    

}
