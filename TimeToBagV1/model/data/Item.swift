//
//  Item.swift
//  TimeToBagV1
//
//  Created by Tal Sahar on 09/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class Item{
    var itemId:String?
    var bagId:String?
    var itemTitle:String?
    var isToken:Bool?
    var lastUpdate:Date?
    
    init(itemId:String,bagId:String,itemTitle:String,isToken:Bool,lastUpdate:Date) {
        self.itemId=itemId
        self.bagId=bagId
        self.itemTitle=itemTitle
        self.isToken=isToken
        self.lastUpdate=lastUpdate
    }
    
    func buildJson()->(Dictionary<String,Any>){
        var json = Dictionary<String,Any>()
        json["itemId"] = itemId
        json["bagId"] = bagId
        json["itemTitle"] = itemTitle
        json["isToken"] = isToken
        json["lastUpdate"] = self.lastUpdate?.toFirebase()
        return json
    }
   
    
    func hasUpdate(){
        
    }
    
}
