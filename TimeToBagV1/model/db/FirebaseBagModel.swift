//
//  FirebaseBagModel.swift
//  TimeToBagV1
//
//  Created by Tal Sahar on 07/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import FirebaseDatabase
import Foundation
class FirebaseBagModel{
    //stores a bag, counting down while storing items, when 0 trigger the callback
    static func storeBag(bag:Bag, completionBlock:@escaping (Error?)->Void){
        let bagJson=bag.buildBagJson()
        let ref = Database.database().reference().child("bags").child(bag.id!)
        ref.setValue(bagJson){(error, dbref) in
            var counter=bag.items.count
           let itemsRef = dbref.child("items")
                  for it in bag.items{
                    let currItemRef=itemsRef.child(it.itemId!)
                    currItemRef.setValue(it.buildJson()){
                        (error, dbref) in
                        counter += -1
                        if counter == 0{
                         completionBlock(error)
                        }
                    }
                }
    }
}



}
