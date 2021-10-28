//
//  AppDelegate.swift
//  Assessment
//
//  Created by Adaikalraj S on 28/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.loadHomeVC()
        return true
    }

    func loadHomeVC(){
        let initialViewController = WelcomeViewController(nibName: "WelcomeViewController", bundle: nil)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
}

