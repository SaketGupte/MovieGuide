//
//  ContentCoodinator.swift
//  MovieGuide
//
//  Created by Saket Gupte on 18/07/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import UIKit

protocol ContentCoordinatorDelegate: class {
}

class ContentCoodinator: Coordinator {

  fileprivate let navigationController: UINavigationController
  fileprivate let listingViewController: ListingViewController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
    self.listingViewController = ListingViewController()
    listingViewController.delegate = self
  }

  func start() {
    self.navigationController.pushViewController(listingViewController, animated: true)
  }

}

extension ContentCoodinator: ListingViewControllerDelegate {
  func showMovieDetails(forId id: Int) {
    let detailViewController = DetailViewController()
    self.navigationController.pushViewController(detailViewController, animated: true)
  }
}
