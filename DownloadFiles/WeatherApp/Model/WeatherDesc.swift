//
//  WeatherDesc.swift
//  downloadFiles
//
//  Created by Tejashree on 25/03/19.
//  Copyright © 2019 Tejashree. All rights reserved.
//

import UIKit

struct WeatherDesc {

    var desc : String!
    var icon : String!
    var id : Int!
    var main : String!
    
   
    
    init(weather:NSDictionary) {
        desc = (weather.object(forKey: "description") as! String)
        icon = (weather.object(forKey: "icon") as! String)
        id = (weather.object(forKey: "id") as! Int)
        main = (weather.object(forKey: "main") as! String)
    }
}
