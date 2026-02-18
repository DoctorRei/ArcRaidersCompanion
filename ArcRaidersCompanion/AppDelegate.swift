//
//  AppDelegate.swift
//  ArcRaidersCompanion
//
//  Created by Akira Rei on 17.02.2026.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var applicationCoordinator: ApplicationCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator.start()

        return true
    }
}
