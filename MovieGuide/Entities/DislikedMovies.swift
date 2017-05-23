//
//  DislikedMovies.swift
//  MovieGuide
//
//  Created by Saket Gupte on 01/05/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RealmSwift

class DislikedMovies: Object {
  
  dynamic var movieId: Int = 0

  override class func primaryKey() -> String? {
    return "movieId"
  }
}
