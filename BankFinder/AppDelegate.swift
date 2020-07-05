//
//  AppDelegate.swift
//  BankFinder
//
//  Created by Mike Camara on 21/6/20.
//  Copyright © 2020 Mike Camara. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Fetch data once an hour.
        UIApplication.shared.setMinimumBackgroundFetchInterval(3600)
        
        let banksViewModel = RegionsList()
        banksViewModel.regionsVM.refreshAllBanks()
        
        return true
    }

    // TODO implement this feature
    
//    func application(_ application: UIApplication,
//                     performFetchWithCompletionHandler completionHandler:
//                     @escaping (UIBackgroundFetchResult) -> Void) {
//       // Check for new data.
//
//       if let newData = fetchUpdates() {
//          addDataToFeed(newData: newData)
//          completionHandler(.newData)
//       }
//       completionHandler(.noData)
//    }
    
    
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

