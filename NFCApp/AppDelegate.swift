//
//  AppDelegate.swift
//  NFCApp
//
//  Created by Richard Adem on 14/6/17.
//  Copyright © 2017 Richard Adem. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let viewController = ViewController()
            window.rootViewController = viewController
            window.backgroundColor = UIColor.white
            window.makeKeyAndVisible()
        }
        
        return true
    }


}

