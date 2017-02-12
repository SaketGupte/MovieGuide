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

  func getListOfMoviesNowPlaying() -> Observable<ListingResponse>

  func getListOfPopularMovies() -> Observable<[Movie]>

  func getListOfUpcomingMovies() -> Observable<[Movie]>

  func getListOfTopRatedMovies() -> Observable<[Movie]>
}
