//
//  DB.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 09/01/22.
//

import Foundation
import SQLite3

class DBHelper {
    static var db: OpaquePointer?
    static var path: String = "myDb.sqlite"

    static func InitializeDB() {
        self.db = createDB()
        createTables()
    }
    
    static func createTables() {
        ItemsDAO.createTable()
        HistoricDAO.createTable()
    }
    
    static func createDB() -> OpaquePointer? {
        
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(path)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Error in DB creation")
            return nil
        } else {
            print("Database has been created with path \(path)")
            return db
        }
    }
}
