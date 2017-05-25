//
//  ListingResponse.swift
//  MovieGuide
//
//  Created by Saket Gupte on 20/01/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Mapper

struct ListingResponse: Mappable {
  
  var movies: [Movie]

  init(map: Mapper) throws {
    try movies = map.from("results")
  }
  
}
