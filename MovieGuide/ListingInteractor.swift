//
//  ListingInteractor.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RxSwift

protocol ListingInteractor {

  func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse>
  
  func getListOfMoviesNowPlaying() -> Observable<ListingResponse>

  func getListOfPopularMovies() -> Observable<ListingResponse>

  func getListOfUpcomingMovies() -> Observable<ListingResponse>

  func getListOfTopRatedMovies() -> Observable<ListingResponse>
}
