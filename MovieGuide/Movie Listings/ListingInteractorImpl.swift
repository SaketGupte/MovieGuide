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
      return dependencies.networkProvider
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
    
    return filterOutDislikedMovies(response: listingResponse)
  }
  
  fileprivate func filterOutDislikedMovies(response: Observable<ListingResponse>) -> Observable<[Movie]> {
    
    let dislikedMoviesId = getIdsOfAllDislikedMovies()

    return  response.map { (listingResponse)  in
      listingResponse.movies.flatMap({ (movie) in
        dislikedMoviesId.contains(movie.id) ? nil : movie
      })
    }
  }
  
  fileprivate func getIdsOfAllDislikedMovies() -> [Int] {
    return localStorageProvider.getAllDislikedMovies().map{$0.movieId}
  }

  func removeMovieFromListing(movieId: Int) {
    let localStorage: LocalStorage = LocalStorageImpl()
    localStorage.addMovieToDislikeList(movieId: movieId)
  }

}
