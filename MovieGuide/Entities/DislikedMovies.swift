//
//  DislikedMovie.swift
//  MovieGuide
//
//  Created by Saket Gupte on 01/05/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RealmSwift

class DislikedMovie: Object {
  
  dynamic var movieId: Int = 0

  convenience init(movieId: Int) {
    self.init()
    self.movieId = movieId
  }

  override class func primaryKey() -> String? {
    return "movieId"
  }
}


extension DislikedMovie: AutoEquatable {}
