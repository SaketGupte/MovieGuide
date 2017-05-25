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
  
  var networkProvider: RxMoyaProvider<MovieGuideEndpoint> {
    get {
      return dependencies.onlineProvider
    }
  }
  
  var localStorageProvider: LocalStorage {
    get {
      return dependencies.storageProvider
    }
  }
  
  var dependencies: ListingInteractor.Dependencies
  
  init(dependencies: ListingInteractor.Dependencies) {
    self.dependencies = dependencies
  }
  
  func getListOfMovies(listOption: MovieListOptions) -> Observable<[Movie]>  {
    
    let listingResponse =  networkProvider
      .request(MovieGuideEndpoint.movieByOption(option: listOption.rawValue))
      .mapObject(type: ListingResponse.self)
    
    return getListOfNotDislikedMovies(response: listingResponse)
  }
  
  func removeMovieFromListing(movieId: Int) {
    let localStorage: LocalStorage = LocalStorageImpl()
    localStorage.addMovieToDislikeList(movieId: movieId)
  }
  
  fileprivate func getListOfNotDislikedMovies(response: Observable<ListingResponse>) -> Observable<[Movie]> {
    
    let dislikedMovies = getAllDislikedMovies()

    return  response.map { (listingResponse)  in
      listingResponse.movies.flatMap({ (movie) in
        dislikedMovies.map { $0.movieId }.contains(movie.id) ? nil : movie
      })
    }
  }
  
  fileprivate func getAllDislikedMovies() -> [DislikedMovies] {
    let localStorage: LocalStorage = LocalStorageImpl()
    return localStorage.getAllDislikedMovies()
  }

  
}
