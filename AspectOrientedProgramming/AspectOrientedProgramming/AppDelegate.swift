//
//  AppDelegate.swift
//  AspectOrientedProgramming
//
//  Created by biesx on 2018/7/3.
//  Copyright © 2018年 biesx. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        TrackManager.setUp()

        return true
    }
}
