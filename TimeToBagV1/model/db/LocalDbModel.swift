//
//  Student+sql.swift
//  TestFb
//
//  Created by Eliav Menachi on 21/12/2016.
//  Copyright © 2016 menachi. All rights reserved.
//

import Foundation


class LocalDbModel{
    static let BAG_TABLE = "BAGS"
    static let BAG_ID = "BAG_ID"
    static let BAG_USERID = "USER_ID"
    static let BAG_DATE = "VACATION_DATE"
    static let BAG_TITLE = "TITLE"
    static let BAG_DESCRIPTION = "VACATION_DESCRIPTION"
    static let BAG_IMAGE_URL = "IMAGE_URL"
    static let BAG_WEATHER = "WEATHER"
    static let BAG_TYPE = "TYPE"
    static let LAST_UPDATE = "LAST_UPDATE"
    
    static let ITEM_TABLE = "ITEMS"
    static let ITEM_ID = "ITEM_ID"
    static let ITEM_BAG_ID = "BAG_ID"
    static let ITEM_TITLE = "TITLE"
    static let ITEM_ISTOKEN = "TOEKN"

    
    
    
    static func createTables(database:OpaquePointer?)->Bool{
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        
        let bagTable = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS " + BAG_TABLE + " ( " + BAG_ID + " TEXT PRIMARY KEY, "
            + BAG_USERID + " TEXT, "
            + BAG_DATE + " DOUBLE, "
            + BAG_TITLE + " TEXT, "
            + BAG_DESCRIPTION + " TEXT, "
            + BAG_IMAGE_URL + " TEXT, "
            + BAG_WEATHER + " TEXT, "
            + BAG_TYPE + " TEXT, "
            + LAST_UPDATE + " DOUBLE)", nil, nil, &errormsg);
        if(bagTable != 0){
            print("error in creation table BAG");
            return false
        }

        let itemTable = sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS " + ITEM_TABLE + " ( " + ITEM_ID + " TEXT PRIMARY KEY, "
            + ITEM_BAG_ID + " TEXT, "
            + ITEM_TITLE + " TEXT, "
            + ITEM_ISTOKEN + " TEXT, "
            + LAST_UPDATE + " DOUBLE)", nil, nil, &errormsg);
        if(itemTable != 0){
            print("error in creation table ITEMS");
            return false
        }
        
        return true
    }
    

    static func addBagToLocalDb(database:OpaquePointer?,bag:Bag?){
        var sqlite3_stmt: OpaquePointer? = nil
        let result=sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO " + BAG_TABLE
            + "(" + BAG_ID + ","
            + BAG_USERID + ","
            + BAG_DATE + ","
            + BAG_TITLE + ","
            + BAG_DESCRIPTION + ","
            + BAG_IMAGE_URL + ","
            + BAG_WEATHER + ","
            + BAG_TYPE + ","
            + LAST_UPDATE + ") VALUES (?,?,?,?,?,?,?,?,?);",-1, &sqlite3_stmt,nil)
        
       if result == SQLITE_OK{
            
            var _imageUrl = "".cString(using: .utf8)
        if bag?.imageUrl != nil {
            _imageUrl = bag?.imageUrl!.cString(using: .utf8)
            }
        
        sqlite3_bind_text(sqlite3_stmt, 1, bag?.id?.cString(using: .utf8),-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, bag?.userId?.cString(using: .utf8),-1,nil);
        sqlite3_bind_double(sqlite3_stmt, 3, (bag?.vacationDate?.toFirebase())!);
            sqlite3_bind_text(sqlite3_stmt, 4, bag?.title?.cString(using: .utf8),-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, bag?.description?.cString(using: .utf8),-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, bag?.imageUrl,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 7, bag?.weather?.rawValue.cString(using: .utf8),-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 8, bag?.vacationType?.rawValue.cString(using: .utf8),-1,nil);
        sqlite3_bind_double(sqlite3_stmt, 9, (bag?.lastUpdate?.toFirebase())!);

            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                sqlite3_finalize(sqlite3_stmt)
                LocalDbModel.addItemsToLocalDb(database: database,items: (bag?.items)!)
            }
        }
    }
        static func addItemsToLocalDb(database:OpaquePointer?,items:[Item]){
            
            var sqlite3_stmt: OpaquePointer? = nil
            
            for item in items{
                let result=sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO " + ITEM_TABLE
                    + "(" + ITEM_ID + ","
                    + ITEM_BAG_ID + ","
                    + ITEM_TITLE + ","
                    + ITEM_ISTOKEN + ","
                    + LAST_UPDATE + ") VALUES (?,?,?,?,?);",-1, &sqlite3_stmt,nil)
                
                if result == SQLITE_OK{
                    sqlite3_bind_text(sqlite3_stmt, 1, item.itemId,-1,nil);
                    sqlite3_bind_text(sqlite3_stmt, 2, item.bagId,-1,nil);
                    sqlite3_bind_text(sqlite3_stmt, 3, item.itemTitle,-1,nil);
                    sqlite3_bind_text(sqlite3_stmt, 4, item.isToken?.description,-1,nil);
                    sqlite3_bind_double(sqlite3_stmt, 5, (item.lastUpdate?.toFirebase())!);

                    if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                        print("item added")
                    }
            }
          
        }
        
//        for item in items{
//            if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO " + ITEM_TABLE
//                + "(" + ITEM_BAG_ID + ","
//                + "(" + ITEM_TITLE + ","
//                + "(" + VALUE + ","
//                + LAST_UPDATE + ") VALUES (?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
//
//                let _id=self.id.cString(using: .utf8)
//                let _title=item.KEY.cString(using: .utf8)
//                let _value=item.VALUE.cString(using: .utf8)
//                sqlite3_bind_text(sqlite3_stmt, 1, _id,-1,nil);
//                sqlite3_bind_text(sqlite3_stmt, 2, _title,-1,nil);
//                sqlite3_bind_text(sqlite3_stmt, 3, _value,-1,nil);
//
//                if (lastUpdate == nil){
//                    lastUpdate = Date()
//                }
//                sqlite3_bind_double(sqlite3_stmt, 4, lastUpdate!.toFirebase());
//
//                if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
//                    print("new item added succefully")
//                }
//            }
//        }
//
        
    }
    
//    static func getAllBagsFromLocalDb(database:OpaquePointer?)->[Student]{
//        var bags = [Bag]()
//        var sqlite3_stmt: OpaquePointer? = nil
//        if (sqlite3_prepare_v2(database,"SELECT * from BAGS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
//            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
//                let stId =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,0))
//                let name =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,1))
//                var imageUrl =  String(validatingUTF8:sqlite3_column_text(sqlite3_stmt,2))
//                let update =  Double(sqlite3_column_double(sqlite3_stmt,3))
//                print("read from filter st: \(stId) \(name) \(imageUrl)")
//                if (imageUrl != nil && imageUrl == ""){
//                    imageUrl = nil
//                }
//                let student = Student(id: stId!,name: name!,imageUrl: imageUrl)
//                student.lastUpdate = Date.fromFirebase(update)
//                students.append(student)
//            }
//        }
//        sqlite3_finalize(sqlite3_stmt)
//        return students
//    }

}
