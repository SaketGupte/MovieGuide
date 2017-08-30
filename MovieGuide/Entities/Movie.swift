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
  let posterURL: URL?
  let backdropURL: URL?
  let isAdultMovie: Bool?
  let originalLanguage: String?
  let releaseDate: String?
  let genres: [Genre]?
  let runningTime: Int?
  let rating: Double?
  let votesReceived: Int?

  init(map: Mapper) throws {
    try id = map.from("id")
    try title = map.from("title")
    overview = map.optionalFrom("overview")
    posterURL = map.optionalFrom("poster_path", transformation: convertToURL)
    backdropURL = map.optionalFrom("backdrop_path", transformation: convertToURL)
    isAdultMovie = map.optionalFrom("adult")
    originalLanguage = map.optionalFrom("original_language")
    releaseDate = map.optionalFrom("release_date")
    genres = map.optionalFrom("genres")
    runningTime = map.optionalFrom("runtime")
    rating = map.optionalFrom("vote_average")
    votesReceived = map.optionalFrom("vote_count")
  }

}

extension Movie: Equatable {
  static func ==(lhs: Movie, rhs: Movie) -> Bool {
    return lhs.id == rhs.id
  }
}

private func convertToURL(object: Any?) throws -> URL {

  guard let imagePath = object as? String else {
    throw MapperError.convertibleError(value: object, type: String.self)
  }

  let completeImagePath =  constants.apiConstants.imageBaseUrl + constants.apiConstants.imageSize + imagePath

  guard let imageURL = URL(string:completeImagePath) else {
    throw MapperError.customError(field: nil, message: "Couldn't convert string to URL!")
  }

  return imageURL

}
