//
//  MovieOverview.swift
//  MovieGuide
//
//  Created by Saket Gupte on 12/21/16.
//  Copyright © 2016 Saket Gupte. All rights reserved.
//

import Mapper

struct Movie: Mappable {

  let id: Int
  let title: String
  let overview: String?
  let posterPath: String?
  let isAdultMovie: Bool?
  let originalLanguage: String?
  let releaseDate: String?
  let rating: Double?

  init(map: Mapper) throws {
    try id = map.from("id")
    try title = map.from("title")
    try overview = map.from("overview")
    try posterPath = map.from("backdrop_path")
    try isAdultMovie = map.from("adult")
    try originalLanguage = map.from("original_language")
    try releaseDate = map.from("release_date")
    try rating = map.from("vote_average")
  }

}
