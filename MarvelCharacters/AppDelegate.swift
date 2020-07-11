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
    let navigationDelegate = NavigationDelegate()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white

        let homeViewController = HomeViewController(withHomeViewModel: HomeViewModel())
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.delegate = navigationDelegate
        
        window?.makeKeyAndVisible()
        window?.rootViewController = navigationController
        
        return true
    }
}
