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
    //fix the completionBlock
    static func storeBag(bag:Bag, completionBlock:@escaping (Error?)->Void){
        var bagJson=bag.buildBagJson()
        var ref = Database.database().reference().child("bags").child(bag.id!)
        ref.setValue(bagJson){(error, dbref) in
            var ref = ref.child("items")
                  for it in bag.items{
                    var itemRef=ref.child(it.itemId!)
                      itemRef.setValue(it.buildJson())
                   }
            completionBlock(error)
        }
    }
        }



