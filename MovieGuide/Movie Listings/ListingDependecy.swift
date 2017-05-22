//
//  ListingDependecy.swift
//  MovieGuide
//
//  Created by Saket Gupte on 24/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation


protocol HasOnlineProvider {
  var onlineProvider: OnlineProvider<MovieGuideEndpoint> {get}
}

struct ListingDependency: HasOnlineProvider {
  let onlineProvider: OnlineProvider<MovieGuideEndpoint>
  
  init(onlineProvider: OnlineProvider<MovieGuideEndpoint> = OnlineProvider()) {
    self.onlineProvider = onlineProvider
  }
  
}
