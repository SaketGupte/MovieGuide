//
//  MovieOverview.swift
//  MovieGuide
//
//  Created by Saket Gupte on 12/21/16.
//  Copyright © 2016 Saket Gupte. All rights reserved.
//

import Mapper

struct Movie: Mappable {
  /**
   Define how your custom object is created from a Mapper object
   */
  init(map: Mapper) throws {
    try id = map.from("id")
    try title = map.from("title")
    try overview = map.from("overview")
    try posterPath = map.from("poster_path")
    try backdropPath = map.from("backdrop_path")
    try isAdultMovie = map.from("adult")
    genres = map.optionalFrom("genres") ?? []
    try originalLanguage = map.from("original_language")
    try runTime = map.from("runtime")
    try status = map.from("status")
    try releaseData = map.from("release_date")
    spokenLanguage = map.optionalFrom("spoken_languages") ?? []
  }

  let id: String
  let title: String
  let overview: String?
  let posterPath: String?
  let backdropPath: String?
  let isAdultMovie: Bool?
  let genres: [Genre]?
  let originalLanguage: String?
  let runTime: Int?
  let status: String?
  let releaseData: String?
  let spokenLanguage: [SpokenLanuage]?
}
