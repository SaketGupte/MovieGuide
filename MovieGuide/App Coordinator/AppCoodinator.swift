//
//  AppCoodinator.swift
//  MovieGuide
//
//  Created by Saket Gupte on 17/07/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
  func start()
}


class AppCoodinator {

  fileprivate let navigationController: UINavigationController
  fileprivate var childCoordinators: [Coordinator] = []

  init(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.customizeNavigationBar()
  }

  func start() {
    self.showContent()
  }

  fileprivate func showContent() {
    let contentCoordinator: ContentCoodinator = ContentCoodinator(navigationController: navigationController)
    contentCoordinator.start()
    childCoordinators.append(contentCoordinator)
  }

  fileprivate func customizeNavigationBar() {
    UINavigationBar.appearance().barTintColor = UIColor.init(colorLiteralRed: 4.0/255.0, green: 131.0/255.0, blue: 123.0/255.0, alpha: 1)
    UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(colorLiteralRed: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1)]
    UINavigationBar.appearance().tintColor = UIColor.init(colorLiteralRed: 241.0/255.0, green: 196.0/255.0, blue: 15.0/255.0, alpha: 1)
  }

}
