//
//  Alert.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 10/01/22.
//

import Foundation
import UIKit

class AlertHelper {
    static func popupAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    func popupAlertHeader(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        return alert
    }
}
