//
//  AppDelegate.swift
//  Ferda
//
//  Created by James Harquail on 2018-05-27.
//  Copyright © 2018 Ragnar Development. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: RootWindow?

    private var core = Core()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        window = RootWindow(core: core)
        window?.makeKeyAndVisible()

        return true
    }
}
