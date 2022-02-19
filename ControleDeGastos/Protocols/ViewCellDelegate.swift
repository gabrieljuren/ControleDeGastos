//
//  ViewCellDelegate.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 10/01/22.
//

import Foundation

protocol ItemCollectionViewCellDelegate: AnyObject {
    func removeItem(cell: ItemCollectionViewCell)
    func editItem(cell: ItemCollectionViewCell)
}
