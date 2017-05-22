//
//  ListingInteractorImpl.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

import Moya
import Moya_ModelMapper
import RxSwift

enum MovieListOptions: String {
  case nowPlaying = "now_playing"
  case popular = "popular"
  case topRated = "top_rated"
  case upcoming = "upcoming"
}

struct ListingInteractorImpl: ListingInteractor {
  
  var provider: RxMoyaProvider<MovieGuideEndpoint> {
    get {
      return dependencies.onlineProvider
    }
  }
  
  var dependencies: ListingInteractor.Dependencies
  
  init(dependencies: ListingInteractor.Dependencies) {
    self.dependencies = dependencies
  }
  
  func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse>  {
    
    return provider
      .request(MovieGuideEndpoint.movieByOption(option: listOption.rawValue))
      .mapObject(type: ListingResponse.self)
  }
  
  func removeMovieFromListing(movieId: Int) {
    let localStorage: LocalStorage = LocalStorageImpl()
    localStorage.addMovieToDislikeList(movieId: movieId)
  }
}
