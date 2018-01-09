//
//  Model.swift
//  TimeToBagV1
//
//  Created by Tal Sahar on 07/01/2018.
//  Copyright © 2018 admin. All rights reserved.
//

import Foundation
class Model{
    static func storeBag(bag:Bag){
        FirebaseBagModel.storeBag(bag: bag, completionBlock: {error in
            if error != nil{
                print("Got an error while storing bag \(error!)")
            }
            let sqlite=ModelSql()
            LocalDbModel.addBagToLocalDb(database: sqlite?.database, bag: bag)
            })
    }
}

