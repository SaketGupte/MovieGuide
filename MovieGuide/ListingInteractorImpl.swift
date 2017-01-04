//
//  ListingInteractorImpl.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

enum MovieListOptions: String {
  case nowPlaying = "now_playing"
  case popular = "popular"
  case topRated = "top_rated"
  case upcoming = "upcoming"
}

class ListingInteractorImpl: ListingInteractor {

  var listingPresenter: ListingPresenter?
  let provider: RxMoyaProvider<MovieGuideEndpoint> = RxMoyaProvider<MovieGuideEndpoint>()

  func getListOfMoviesNowPlaying() -> Observable<[Movie]> {
    return self.provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
      .mapArrayOptional(type: Movie.self)
  }

  func getListOfPopularMovies() -> Observable<[Movie]> {
    return self.provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.popular.rawValue))
      .mapArrayOptional(type: Movie.self)
  }

  func getListOfUpcomingMovies() -> Observable<[Movie]> {
    return self.provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.upcoming.rawValue))
      .mapArrayOptional(type: Movie.self)
  }

  func getListOfTopRatedMovies() -> Observable<[Movie]> {
    return self.provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.topRated.rawValue))
      .mapArrayOptional(type: Movie.self)
  }
}
