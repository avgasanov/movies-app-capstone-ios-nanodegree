//
//  AppDelegate.swift
//  Movie Sessions App
//
//  Created by Abdulla Hasanov on 11/30/19.
//  Copyright © 2019 Abdulla Hasanov. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        MovieClient.initDatabase()
        return true
    }

}

