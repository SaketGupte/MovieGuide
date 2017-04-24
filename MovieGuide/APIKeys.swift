//
//  APIKeys.swift
//  MovieGuide
//
//  Created by Saket Gupte on 20/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import Keys

struct APIKeys {
  
  let key: String

  fileprivate struct SharedKeys {
    static var instance = APIKeys()
  }
  
  static var sharedKeys: APIKeys {
    get {
      return SharedKeys.instance
    }
    
    set (newSharedKeys){
      SharedKeys.instance = newSharedKeys
    }
  }
  
  var stubResponse: Bool {
    return key.characters.count < 2
  }
  
  init() {
    let keys = MovieGuideKeys()
    key  = keys.movieDBClientKey
  }
}
