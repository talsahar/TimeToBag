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
    var items = [Item]()
    var lastUpdate:Date?
   
   
    init(id:String,userId:String,title:String,description:String,vacationDate:Date,imageUrl:String,weather:Weather,vacationType:VacationType,items:[Item]?){
        self.id=id;
        self.userId=userId
        self.title=title
        self.description=description
        self.vacationDate=vacationDate
        self.imageUrl=imageUrl
        self.weather=weather
        self.vacationType=vacationType
        if(items != nil){
            self.items=items!
        }
        else{
            self.items=[Item]()

        }
        

    }
    
    func append(item:Item){
        items.append(item)
    }

    func buildBagJson()->Dictionary<String, Any>{
        var json = Dictionary<String, Any>()
        json["id"] = id
        json["userId"] = userId
        json["title"] = title
        json["description"] = description
        json["vacationDate"]=vacationDate?.toFirebase()
        if (imageUrl != nil){
            json["imageUrl"] = imageUrl!
        }
        json["weather"]=weather?.rawValue
        json["vacationType"]=vacationType?.rawValue
        if lastUpdate == nil{
            lastUpdate=Date()
        }
        json["lastUpdate"] = self.lastUpdate?.toFirebase()
        
        
        return json
    }

    
//    func buildJson()->(Dictionary<String, Any>,[Dictionary<String,Any>]){
//        var json = Dictionary<String, Any>()
//                json["id"] = id
////                json["userId"] = userId
////                json["title"] = title
////                json["description"] = description
////               // json["vacationDate"]=vacationDate?.toFirebase()
////                if (imageUrl != nil){
////                    json["imageUrl"] = imageUrl!
////                }
////                json["weather"]=weather?.rawValue
////                json["vacationType"]=vacationType?.rawValue
//               // json["lastUpdate"] = self.lastUpdate?.toFirebase()
//
//        var jsonItems=[Dictionary<String,Any>]()
//    for item in items {
//        jsonItems.append(item.buildJson())
//    }
//        return (json,jsonItems)
//    }
//
//    func hasUpdate(){
//
//    }
    
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

    
  

}
