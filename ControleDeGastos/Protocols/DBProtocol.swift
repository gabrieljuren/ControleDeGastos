//
//  DBProtocol.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 12/01/22.
//

import Foundation

protocol DBProtocol {
    static func DeleteItem(Id: Int)
    static func Update(with model: Any)
    static func SelectAll() -> [Any]
    static func Insert(with model: Any)
    static func createTable()
}
