//
//  TabBarInitializeViewController.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 30/12/21.
//

import Foundation
import UIKit

class TabBarInitializeViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        let tabBar = UITabBarController()
        let criarItemViewController = UINavigationController(rootViewController: CriarItemViewController())
        let itensCollectionViewController = UINavigationController(rootViewController: ItensCollectionViewController())
        let historicViewConroller = UINavigationController(rootViewController: HistoricViewController())
        
        criarItemViewController.title = "Criar Item"
        criarItemViewController.tabBarItem.image = UIImage(systemName: "plus.app.fill")
        
        itensCollectionViewController.title = "Itens"
        itensCollectionViewController.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.portrait")
        
        historicViewConroller.title = "Histórico"
        historicViewConroller.tabBarItem.image = UIImage(systemName: "timer")
        
        tabBar.setViewControllers([criarItemViewController, itensCollectionViewController, historicViewConroller], animated: true)
        tabBar.modalPresentationStyle = .fullScreen
        
        present(tabBar, animated: true)
    }
}
