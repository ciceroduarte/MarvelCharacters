//
//  AppDelegate.swift
//  MarvelCharacters
//
//  Created by Cicero on 15/02/17.
//  Copyright © 2017 ciceroduarte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        let homeViewController = HomeViewController(withHomeViewModel: HomeViewModel())
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.tintColor = .white
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
}
