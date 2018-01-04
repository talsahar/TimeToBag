//
//  Bag.swift
//  TimeToBagV1
//
//  Created by admin on 31/12/2017.
//  Copyright © 2017 admin. All rights reserved.
//
import UIKit
import Foundation
import FirebaseDatabase

class Bag{
    var id:String?
    var userId:String?
    var title:String?
    var description:String?
    var vacationDate:Date?
    var imageUrl:String?
    var weather:Weather?
    var vacationType:VacationType?
    var items = [String: Bool]()
    var lastUpdate:Date?
    init(id:String,userId:String,title:String,description:String,vacationDate:Date,imageUrl:String,weather:Weather,vacationType:VacationType,items:[String:Bool]?){
        self.id=id;
        self.userId=userId
        self.title=title
        self.description=description
        self.vacationDate=vacationDate
        self.imageUrl=imageUrl
        self.weather=weather
        self.vacationType=vacationType
        if items != nil{
            self.items=items!
        }
    }
    
    func append(item:String,isTicked:Bool){
        items[item]=isTicked
    }
    
    func setValueOfItem(item:String,setTo:Bool){
        items[item]=setTo
    }
    
//    init(jsonA:Dictionary<String,Any>,jsonB:Dictionary<String,Any>){
//        id = jsonA["id"] as! String!
//        userId = jsonA["userId"] as! String!
//        if let im = jsonA["imageUrl"] as? String!{
//            imageUrl = im
//        }
//        title=jsonA["title"] as! String!
//        description=jsonA["description"] as! String!
//        weather=Weather(rawValue:(jsonA["weather"] as? String)!)
//        vacationType=VacationType(rawValue:(jsonA["vacationType"] as? String)!)
//        if let ts = jsonA["lastUpdate"] as? Double{
//            self.lastUpdate = Date.fromFirebase(ts)
//        }
//        
//        for item in jsonB{
//            items[jsonB[item.key] as! String]=item.value as! Bool
//        }
//        
//    }
//    
//    func bagToFirebase() -> (Dictionary<String,Any>,Dictionary<String,Any>){
//        var jsonA = Dictionary<String,Any>()
//        jsonA["id"] = id
//        jsonA["userId"] = userId
//        jsonA["title"] = title
//        jsonA["description"] = description
//        jsonA["vacationDate"]=Date.toFirebase(vacationDate!)
//        if (imageUrl != nil){
//            jsonA["imageUrl"] = imageUrl!
//        }
//        jsonA["weather"]=weather?.rawValue
//        jsonA["vacationType"]=vacationType?.rawValue
//        jsonA["lastUpdate"] = ServerValue.timestamp()
//        
//        var jsonB = Dictionary<String,Any>()
//        items.forEach { item in
//        jsonB[item.key]=item.value
//        }
//        
//        return (jsonA,jsonB)
//    }
    
  

}
