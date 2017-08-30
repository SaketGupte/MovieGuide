//
//  DetailInteractorImpl.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RxSwift

struct DetailInteractorImpl: DetailInteractor {

  let dependencies: DetailInteractor.Dependency

  var networkProvider: OnlineProvider<MovieGuideEndpoint> {
    get {
      return dependencies.networkProvider
    }
  }

  var storageProvide: LocalStorage {
    get {
      return dependencies.storageProvider
    }
  }

  init(dependencies: DetailInteractor.Dependency) {
    self.dependencies = dependencies
  }

  func getDetailsForMovie(withId movieId: Int) -> Observable<Movie> {
    let response = networkProvider
      .request(MovieGuideEndpoint.movieDetails(movieId: movieId))
      .mapObject(type: Movie.self)

    return response
  }

  func removeMovieFromListing(movieId: Int) {
  }
}
