//
//  DetailDependency.swift
//  MovieGuide
//
//  Created by Saket Gupte on 15/08/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

struct DetailDependency: HasNetworkProvider, HasStorageProvider {

  let networkProvider: OnlineProvider<MovieGuideEndpoint>
  let storageProvider: LocalStorage

  init(networkProvider: OnlineProvider<MovieGuideEndpoint> = OnlineProvider(),
       storageProvider: LocalStorage = LocalStorageImpl()) {

    self.networkProvider = networkProvider
    self.storageProvider = storageProvider
  }
}
