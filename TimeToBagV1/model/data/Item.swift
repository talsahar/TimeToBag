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
    
    init(itemId:String,bagId:String,itemTitle:String,isToken:Bool) {
        self.itemId=itemId
        self.bagId=bagId
        self.itemTitle=itemTitle
        self.isToken=isToken
    }
    init(json:Dictionary<String,Any>){
        itemId = json["itemId"] as! String
        bagId = json["bagId"] as! String
        itemTitle=json["itemTitle"] as! String
        isToken=json["isToken"] as! Bool
       
    }
    
    
    func buildJson()->(Dictionary<String,Any>){
        var json = Dictionary<String,Any>()
        json["itemId"] = itemId
        json["bagId"] = bagId
        json["itemTitle"] = itemTitle
        json["isToken"] = isToken
        return json
    }
   
    
}
