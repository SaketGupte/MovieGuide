//
//  ListingInteractor.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RxSwift
import Moya

protocol HasNetworkProvider {
  var networkProvider: OnlineProvider<MovieGuideEndpoint> {get}
}

protocol HasStorageProvider {
  var storageProvider: LocalStorage {get}
}

protocol ListingInteractor {

  typealias Dependencies = HasNetworkProvider & HasStorageProvider
  
  var dependencies: Dependencies{get}
  
  func getListOfMovies(listOption: MovieListOptions) -> Observable<[Movie]>
  
  func removeMovieFromListing(movieId: Int)
}
