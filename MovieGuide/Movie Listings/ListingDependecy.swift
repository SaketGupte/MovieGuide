//
//  ListingDependecy.swift
//  MovieGuide
//
//  Created by Saket Gupte on 24/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation


protocol HasNetworkProvider {
  var onlineProvider: OnlineProvider<MovieGuideEndpoint> {get}
}

protocol HasStorageProvider {
  var storageProvider: LocalStorage {get}
}

struct ListingDependency: HasNetworkProvider, HasStorageProvider {
  let onlineProvider: OnlineProvider<MovieGuideEndpoint>
  let storageProvider: LocalStorage
  
  init(onlineProvider: OnlineProvider<MovieGuideEndpoint> = OnlineProvider(),
       storageProvider: LocalStorage = LocalStorageImpl()) {
    self.onlineProvider = onlineProvider
    self.storageProvider = storageProvider
  }
}
