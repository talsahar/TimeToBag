//
//  VacationTypeDataGenerator.swift
//  TimeToBagV1
//
//  Created by admin on 31/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import Foundation
import Foundation
import UIKit
class VacationTypeDataGenerator{
    static func generate() -> [VacationType:UIImage?] {
        return [
            VacationType.Beach : UIImage(named: "beach"),
            VacationType.City : UIImage(named: "city"),
            VacationType.Family : UIImage(named: "family"),
            VacationType.Hotel : UIImage(named: "hotel"),
            VacationType.Romantic : UIImage(named: "romantic"),
            VacationType.Ski : UIImage(named: "ski"),
            VacationType.Luxury : UIImage(named: "luxury")
            
        ]
        
    }
    
    
}
