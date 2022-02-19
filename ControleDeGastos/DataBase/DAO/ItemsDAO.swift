//
//  ItemsDAO.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 12/01/22.
//

import Foundation
import SQLite3

class ItemsDAO: DBProtocol {
    
    static func DeleteItem(Id: Int) {
        
        var deleteStatement: OpaquePointer? = nil
        let query = "DELETE FROM ITEMS WHERE ID = \(Id)"
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &deleteStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Id \(Id) has been deleted.")
            } else {
                print("\nCould not delete row.")
            }
            
        } else {
            print("\nDELETE statement is not prepared.")
        }
        
        sqlite3_finalize(deleteStatement)
    }
    
    static func Update(with model: Any) {
        
        let itemModel = model as! ItemModel
        var updateStatement: OpaquePointer? = nil
        
        let query = "UPDATE ITEMS SET Nome = '\(itemModel.Nome)', Valor = \(itemModel.Valor), ValorObjetivo = \(itemModel.ValorObjetivo) WHERE ID = \(itemModel.Id)"
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &updateStatement, nil) == SQLITE_OK {
            
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("Updated row.")
            } else {
                print("\nCould not update row.")
            }
            
        } else {
            print("\nUPDATE statement is not prepared.")
        }
        
        sqlite3_finalize(updateStatement)
    }
    
    static func SelectAll() -> [Any] {
        
        var items = [ItemModel]()
        var model = ItemModel(Id: 0, Nome: "", Valor: 0, ValorObjetivo: 0, IsGoalReached: false)
        
        var selectStatement: OpaquePointer? = nil
        let query = "SELECT * FROM ITEMS"
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &selectStatement, nil) == SQLITE_OK {
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(selectStatement, 0)
                
                guard let queryResultNome = sqlite3_column_text(selectStatement, 1) else {
                    print("Nome result is nil")
                    return []
                }
                
                let queryResultValor = sqlite3_column_double(selectStatement, 2)
                let queryResultValorObjetivo = sqlite3_column_double(selectStatement, 3)
                
                model.Nome = String(cString: queryResultNome)
                model.Valor = Double(queryResultValor)
                model.Id = Int(id)
                model.ValorObjetivo = Double(queryResultValorObjetivo)
                
                items.append(model)
                print("Id: \(id), Nome: \(model.Nome), Valor: \(model.Valor), Valor Objetivo: \(model.Valor)")
            }
            
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(DBHelper.db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        
        sqlite3_finalize(selectStatement)
        return items 
    }
    
    static func Insert(with model: Any) {
        
        let itemModel = model as! ItemModel
        var insertStatement: OpaquePointer? = nil
        let query = "INSERT INTO ITEMS (Nome, Valor, ValorObjetivo) VALUES (?, ?, ?)"
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, itemModel.Nome, -1, nil)
            sqlite3_bind_double(insertStatement, 2, itemModel.Valor)
            sqlite3_bind_double(insertStatement, 3, itemModel.ValorObjetivo)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Inserted row.")
            } else {
                print("\nCould not insert row.")
            }
            
        } else {
            print("\nINSERT statement is not prepared.")
        }
        
        sqlite3_finalize(insertStatement)
    }
    
    static func createTable() {
        
        let query = "CREATE TABLE IF NOT EXISTS ITEMS (ID INTEGER PRIMARY KEY AUTOINCREMENT, Nome text, Valor DOUBLE, ValorObjetivo DOUBLE)"
        
        var createTable: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &createTable, nil) == SQLITE_OK {
            
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table ITEMS has been created.")
            } else {
                print("Table ITEMS has falied.")
            }
        } else {
            print("Fail")
        }
        
        sqlite3_finalize(createTable)
    }
}
