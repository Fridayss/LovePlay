//
//  AppDelegate.swift
//  LovePlay
//
//  Created by weiying on 2017/3/10.
//  Copyright © 2017年 yuns. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        self.window?.rootViewController =  MainTabBarController()
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

