//
//  Model.swift
//  TimeToBagV1
//
//  Created by Tal Sahar on 07/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


class ModelNotification{
    static let bagList = MyNotificationBase<[Bag]>(name: "bagListNotification")
    static let bag = MyNotificationBase<Bag>(name: "bagNotification")
    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
}

class Model{
    static let sqlite=ModelSql()

    static func storeBag(bag:Bag){
            //store bag
            FirebaseBagModel.storeBag(bag: bag, completionBlock: {error in
                if error != nil{
                    print("Got an error while storing bag \(error!)")
                }
                //store on sqlite
                LocalDbModel.addBagToLocalDb(database: sqlite?.database, bag: bag)
            })
      
    }
    
    static func getAllBagsAndObserve(){
        let lastUpdateDate = LastUpdateTable.getLastUpdateDate(database: Model.sqlite?.database, table: LocalDbModel.BAG_TABLE)
        // get all updated records from firebase
        FirebaseBagModel.loadAllBagsAndObserve(lastUpdateDate, callback: { (bags) in
            ModelNotification.bagList.post(data: bags)

//            var lastUpdate:Date?
//            for bag in bags{
//                LocalDbModel.addBagToLocalDb(database: Model.sqlite?.database, bag: bag)
//                if lastUpdate == nil{
//                    lastUpdate = bag.lastUpdate
//                }else{
//                    if lastUpdate!.compare(bag.lastUpdate!) == ComparisonResult.orderedAscending{
//                        lastUpdate = bag.lastUpdate
//                    }
//                }
//            }
//            //upadte the last update table
//            if (lastUpdate != nil){
//                LastUpdateTable.setLastUpdate(database: Model.sqlite?.database, table: LocalDbModel.BAG_TABLE, lastUpdate: lastUpdate!)
//                }
//            //get the complete list from local DB
//            let totalList = LocalDbModel.loadAllBagsFromLocal(database: Model.sqlite?.database)
        })
    }
    
}

