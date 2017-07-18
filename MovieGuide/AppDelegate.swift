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
  var appCoordinator: AppCoodinator?
  lazy var rootViewController = UINavigationController()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = self.rootViewController
    self.appCoordinator = AppCoodinator(self.rootViewController)
    self.appCoordinator?.start()
    window?.makeKeyAndVisible()
    return true
  }

}
