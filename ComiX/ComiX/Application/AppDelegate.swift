//
//  AppDelegate.swift
//  ComiX
//
//  Created by Alexis on 11/24/16.
//  Copyright © 2016 Alexis Borovik. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window          : UIWindow?
    var comixListVC     : ComixListViewController!
    var navController   : UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        comixListVC = ComixListViewController(nibName: nil, bundle: nil)
        navController = UINavigationController(rootViewController: comixListVC!)
        window!.rootViewController = navController
        window!.makeKeyAndVisible()
        return true
    }

}

