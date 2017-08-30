//
//  DetailViewModel.swift
//  MovieGuide
//
//  Created by Saket Gupte on 15/08/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

struct DetailViewModel {

  let movieId: Int
  let title: String
  let ageGroup: String?
  let runningTime: String?
  let genres: String?
  let isRated: Bool
  let rating: String?
  let votesReceived: String?
  let overview: String?
  let backgroundImageURL: URL?
  let posterImageURL: URL?

}
