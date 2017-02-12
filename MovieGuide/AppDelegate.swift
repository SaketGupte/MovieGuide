//
//  AppDelegate.swift
//  MovieGuide
//
//  Created by Saket Gupte on 12/18/16.
//  Copyright © 2016 Saket Gupte. All rights reserved.
//

import UIKit

let ListingViewControllerIdentifier = "ListingViewController"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let listingInteractor = ListingInteractorImpl()
    var listingPresenter = ListingPresenterImpl()
    listingPresenter.listingInteractor = listingInteractor
    
    let listingViewController = self.listingViewControllerFromStoryboard()
    listingPresenter.listingView = listingViewController
    listingViewController.listingPresenter = listingPresenter

    self.showRootViewController(listingViewController)
    
    return true
  }

  func listingViewControllerFromStoryboard() -> ListingViewController {
    let storyboard = mainStoryboard()
    let viewController = storyboard.instantiateViewController(withIdentifier: ListingViewControllerIdentifier) as! ListingViewController
    return viewController
  }
  
  func mainStoryboard() -> UIStoryboard {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    return storyboard
  }

  func showRootViewController(_ viewController: UIViewController) {
    let navigationController = navigationControllerFromWindow()
    navigationController.viewControllers = [viewController]
  }
  
  func navigationControllerFromWindow() -> UINavigationController {
    let navigationController = window?.rootViewController as! UINavigationController
    return navigationController
  }


}

