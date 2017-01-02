//
//  MovieOverview.swift
//  MovieGuide
//
//  Created by Saket Gupte on 12/21/16.
//  Copyright © 2016 Saket Gupte. All rights reserved.
//

import Foundation

struct Movie {
  public let id: String
  public let title: String
  public let overview: String?
  public let posterPath: String?
  public let backdropPath: String?
  public let isAdultMovie: Bool?
  public let genres: [Genre]?
  public let originalLanguage: String?
  public let runTime: Int?
  public let status: String?
  public let releaseData: Date?
  public let spokenLanguage: [SpokenLanuage]?
}
