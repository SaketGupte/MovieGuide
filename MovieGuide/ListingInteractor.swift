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

protocol ListingInteractor {

  typealias Dependencies = HasOnlineProvider
  
  var dependencies: Dependencies{get}
  
  func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse>
  
  func removeMovieFromListing(movieId: Int)
}
