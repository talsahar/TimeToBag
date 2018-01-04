//
//  SeassonDataGenerator.swift
//  TimeToBag
//
//  Created by admin on 26/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import UIKit
class WeatherDataGenerator{
      static func generate() -> [Weather:UIImage?] {
        return [
            
            Weather.Clouds : UIImage(named: "clouds_weather"),
            Weather.Rain : UIImage(named: "rain_weather"),
            Weather.Storm : UIImage(named: "storm_weather"),
            Weather.Snow : UIImage(named: "snow_weather"),
            Weather.Sun : UIImage(named: "hot_weather")
        ]
        
    }
    
    
}
