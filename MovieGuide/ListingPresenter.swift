//
//  ListingPresenter.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

protocol ListingPresenter {

  func getListOfMoviesNowPlaying()

  func getListOfPopularMovies()

  func getListOfUpcomingMovies()

  func getListOfTopRatedMovies()
}
