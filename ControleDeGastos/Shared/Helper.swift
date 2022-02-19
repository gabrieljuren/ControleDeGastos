//
//  Helper.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 01/02/22.
//

import Foundation

class Helper {
    
    func DateToString(dateParametter: Date) -> String {
        
        let dateFormatted: String
        let date = dateParametter
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        dateFormatted = dateFormatter.string(from: date)
        
        return dateFormatted
    }
}
