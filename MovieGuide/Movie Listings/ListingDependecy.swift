//
//  ListingDependecy.swift
//  MovieGuide
//
//  Created by Saket Gupte on 24/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

//TODO: Auto Generate this kind of code using Sourcery

struct ListingDependency: HasNetworkProvider, HasStorageProvider {
  let networkProvider: OnlineProvider<MovieGuideEndpoint>
  let storageProvider: LocalStorage
  
  init(networkProvider: OnlineProvider<MovieGuideEndpoint> = OnlineProvider(),
       storageProvider: LocalStorage = LocalStorageImpl()) {
    self.networkProvider = networkProvider
    self.storageProvider = storageProvider
  }
}
