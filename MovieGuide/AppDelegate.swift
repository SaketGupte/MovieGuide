//
//  AppDelegate.swift
//  MovieGuide
//
//  Created by Saket Gupte on 12/18/16.
//  Copyright © 2016 Saket Gupte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: ListingViewController())
    customizeNavigationBar()
    window?.makeKeyAndVisible()
    return true
  }

  fileprivate func customizeNavigationBar() {
    UINavigationBar.appearance().barTintColor = UIColor.init(colorLiteralRed: 4.0/255.0, green: 131.0/255.0, blue: 123.0/255.0, alpha: 1)
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1)]
    UINavigationBar.appearance().tintColor = UIColor.init(colorLiteralRed: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1)
  }
}
