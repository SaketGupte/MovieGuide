//
//  Genre.swift
//  MovieGuide
//
//  Created by Saket Gupte on 12/22/16.
//  Copyright © 2016 Saket Gupte. All rights reserved.
//

import Mapper

struct Genre: Mappable {

  let id: String
  let name: String

  init(map: Mapper) throws {
    try id = map.from("id")
    try name = map.from("name")
  }

}
