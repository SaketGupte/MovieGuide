//
//  ListingConfigurator.swift
//  MovieGuide
//
//  Created by Saket Gupte on 04/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

class ListingConfigurator {
  static let sharedInstance = ListingConfigurator()
  
  func configure(viewController: ListingViewController?)
  {
    guard let viewController = viewController else {
      return
    }
    
    let listingInteractor = ListingInteractorImpl(dependencies: ListingDependency())
    
    let listingPresenter = ListingPresenterImpl()
    listingPresenter.listingInteractor = listingInteractor
    listingPresenter.listingView = viewController
    
    viewController.listingPresenter = listingPresenter
  }
}
