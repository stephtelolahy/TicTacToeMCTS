//
//  AppDelegate.swift
//  TicTacToeMCTS
//
//  Created by Hugues Stéphano TELOLAHY on 30/05/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = DIContainer.provideInitialviewController()
        window?.makeKeyAndVisible()

        return true
    }
}
