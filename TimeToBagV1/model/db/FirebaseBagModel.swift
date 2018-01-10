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
    
    static func loadAllBagsAndObserve(_ lastUpdateDate:Date?, callback:@escaping ([Bag])->Void){
        print("FB: loadAllBagsAndObserve")
        let handler = {(snapshot:DataSnapshot) in
            var bags = [Bag]()
            for child in snapshot.children.allObjects{
                if let childData = child as? DataSnapshot{
                    if let json = childData.value as? Dictionary<String,Any>{
                        let bag = Bag(json: json)
                        bags.append(bag)
                    }
                }
            }
            callback(bags)
        }
        
        let ref = Database.database().reference().child("bags")
        if (lastUpdateDate != nil){
            print("q starting at:\(lastUpdateDate!) \(lastUpdateDate!.toFirebase())")
            let fbQuery = ref.queryOrdered(byChild:"lastUpdate").queryStarting(atValue:lastUpdateDate!.toFirebase())
            fbQuery.observe(DataEventType.value, with: handler)
        }else{
            ref.observe(DataEventType.value, with: handler)
        }
    }
    
    
    //stores a bag, counting down while storing items, when 0 trigger the callback
    static func storeBag(bag:Bag, completionBlock:@escaping (Error?)->Void){
        let bagJson=bag.buildBagJson()
        let ref = Database.database().reference().child("bags").child(bag.id!)
        ref.setValue(bagJson){(error, dbref) in
//            var counter=bag.items.count
            let dispatchTask = DispatchGroup()
            let itemsRef = Database.database().reference().child("items")
            for it in bag.items{
                dispatchTask.enter()
                let currItemRef=itemsRef.child(it.itemId!)
                currItemRef.setValue(it.buildJson()){
                    (error, dbref) in
                    dispatchTask.leave()
//                    counter += -1
//                    if counter == 0{
//                        completionBlock(error)
//                    }
                }
            }
            dispatchTask.notify(queue: .main, execute: {
                completionBlock(error)
            })
        }
    }
}
