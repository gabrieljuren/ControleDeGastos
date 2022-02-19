//
//  ItemModel.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 30/12/21.
//

import Foundation

struct ItemModel: Codable {
    var Id: Int
    var Nome: String
    var Valor: Double
    var ValorObjetivo: Double
    var IsGoalReached: Bool
}
