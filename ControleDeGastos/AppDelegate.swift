//
//  AppDelegate.swift
//  ControleDeGastos
//
//  Created by Gabriel Juren on 30/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarInitializeViewController()
        window?.makeKeyAndVisible()
        
        DBHelper.InitializeDB()
        return true
    }
}

