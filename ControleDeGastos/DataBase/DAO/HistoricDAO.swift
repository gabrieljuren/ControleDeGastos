//
//  HistoricDAO.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 12/01/22.
//

import Foundation
import SQLite3

class HistoricDAO: DBProtocol {
    
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
        let historicModel = model as! HistoricModel
        var updateStatement: OpaquePointer? = nil
        
        let query = "UPDATE HISTORIC SET Nome = '\(historicModel.Nome)', Valor = \(historicModel.Valor), ValorObjetivo = \(historicModel.ValorObjetivo), DataFinlizado = '\(historicModel.DataFinalizado)' WHERE ID = \(historicModel.Id)"
        
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
        var items = [HistoricModel]()
        var model = HistoricModel(Id: 0, Nome: "", Valor: 0, ValorObjetivo: 0, DataFinalizado: Date())
        
        var selectStatement: OpaquePointer? = nil
        let query = "SELECT * FROM HISTORIC"
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &selectStatement, nil) == SQLITE_OK {
            while sqlite3_step(selectStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(selectStatement, 0)
                
                guard let queryResultNome = sqlite3_column_text(selectStatement, 1) else {
                    print("Nome result is nil")
                    return []
                }
                
                let queryResultValor = sqlite3_column_double(selectStatement, 2)
                let queryResultValorObjetivo = sqlite3_column_double(selectStatement, 3)
                var date = Date()
                
                if sqlite3_column_type(selectStatement, 4) != SQLITE_NULL {
                    date = Date(timeIntervalSinceReferenceDate: sqlite3_column_double(selectStatement, 4))
                }
                
                print(String(cString: queryResultNome))
                print(date)
                
                model.Nome = String(cString: queryResultNome)
                model.Valor = Double(queryResultValor)
                model.Id = Int(id)
                model.ValorObjetivo = Double(queryResultValorObjetivo)
                model.DataFinalizado = date
                
                items.append(model)
                
                print("Id: \(id), Nome: \(model.Nome), Valor: \(model.Valor), Valor Objetivo: \(model.Valor), DataFinalizado \(model.DataFinalizado)")
            }
            
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(DBHelper.db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        
        sqlite3_finalize(selectStatement)
        return items
    }
    
    static func Insert(with model: Any) {
        
        let historicModel = model as! HistoricModel
        var insertStatement: OpaquePointer? = nil
        let query = "INSERT INTO HISTORIC (Nome, Valor, ValorObjetivo, DataFinalizado) VALUES (?, ?, ?, ?)"
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, historicModel.Nome, -1, nil)
            sqlite3_bind_double(insertStatement, 2, historicModel.Valor)
            sqlite3_bind_double(insertStatement, 3, historicModel.ValorObjetivo)
            sqlite3_bind_double(insertStatement, 4, historicModel.DataFinalizado.timeIntervalSinceReferenceDate)
            
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
        let query = "CREATE TABLE IF NOT EXISTS HISTORIC (ID INTEGER PRIMARY KEY AUTOINCREMENT, Nome text, Valor DOUBLE, ValorObjetivo DOUBLE, DataFinalizado datetime)"
        
        var createTable: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(DBHelper.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table HISTORIC has been created.")
            } else {
                print("Table HISTORIC has falied.")
            }
        } else {
            print("Fail")
        }
        
        sqlite3_finalize(createTable)
    }
}
