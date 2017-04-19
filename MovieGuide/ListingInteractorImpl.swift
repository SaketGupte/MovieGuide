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

struct ListingInteractorImpl: ListingInteractor {

  var listingPresenter: ListingPresenter?
  
  let provider: RxMoyaProvider<MovieGuideEndpoint> = RxMoyaProvider<MovieGuideEndpoint>(plugins: [NetworkLoggerPlugin(verbose:true)])

  func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse>  {
    
    return provider
      .request(MovieGuideEndpoint.movieByOption(option: listOption.rawValue))
      .mapObject(type: ListingResponse.self)
  }
  
  func getListOfMoviesNowPlaying() -> Observable<ListingResponse> {
    return provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.popular.rawValue))
      .mapObject(type: ListingResponse.self)
  }

  func getListOfPopularMovies() -> Observable<ListingResponse> {
    return provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.popular.rawValue))
      .mapObject(type: ListingResponse.self)
  }

  func getListOfUpcomingMovies() -> Observable<ListingResponse> {
    return provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.upcoming.rawValue))
      .mapObject(type: ListingResponse.self)
  }

  func getListOfTopRatedMovies() -> Observable<ListingResponse> {
    return provider
      .request(MovieGuideEndpoint.movieByOption(option: MovieListOptions.topRated.rawValue))
      .mapObject(type: ListingResponse.self)
  }
}
