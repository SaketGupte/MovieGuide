
//
//  DetailInteractor.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailInteractor {
  typealias Dependency = HasNetworkProvider & HasStorageProvider

  var dependencies: Dependency {get}

  func getDetailsForMovie(withId movieId: Int) -> Observable<Movie>

  func removeMovieFromListing(movieId: Int)
}
