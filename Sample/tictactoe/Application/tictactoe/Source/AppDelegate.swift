//
//  AppDelegate.swift
//  todo
//
//  Created by JSilver on 2022/12/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Property
    
    // MARK: - Lifecylce
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url)
        return true
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
