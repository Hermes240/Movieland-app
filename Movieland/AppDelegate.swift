//
//  AppDelegate.swift
//  Movieland
//
//  Created by Hermes Obiang on 4/21/20.
//  Copyright © 2020 Hermes Obiang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if(UserDefaults.standard.object(forKey: "sortByTitle") == nil)
        {
            UserDefaults.standard.set(false, forKey: "sortByTitle")
        }
        
        if(UserDefaults.standard.object(forKey: "sortByRating") == nil)
        {
            UserDefaults.standard.set(false, forKey: "sortByRating")
        }
        if(UserDefaults.standard.object(forKey: "userRating") == nil)
        {
            let dict: Dictionary<String, Double> = ["Hermes":10.0]
            UserDefaults.standard.set(dict, forKey: "userRating")
        }
        
        if(UserDefaults.standard.object(forKey: "limit") == nil)
        {
            UserDefaults.standard.set(10, forKey: "limit")
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

