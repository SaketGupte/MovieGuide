//
//  LocalStorageSpy.swift
//  MovieGuide
//
//  Created by Saket Gupte on 10/07/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
@testable import MovieGuide


class LocalStorageSpy: LocalStorage {

  var addMovieToDislikeListCalled = false
  var getAllDislikeMovieCalled = false

  func addMovieToDislikeList(movieId: Int) {
    addMovieToDislikeListCalled = true
  }

  func getAllDislikedMovies() -> [DislikedMovie] {
    getAllDislikeMovieCalled = true

    let dislikedMovies: [DislikedMovie] = [DislikedMovie(movieId:1), DislikedMovie(movieId:2)];
    return dislikedMovies
  }
}
