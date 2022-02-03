//
//  AppDelegate.swift
//  mvvm+combine-swift
//
//  Created by João Vitor Duarte Mariucio on 03/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let home = HomeViewController(viewModel: .init())

        let navigationController = UINavigationController()
        navigationController.viewControllers = [home]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
