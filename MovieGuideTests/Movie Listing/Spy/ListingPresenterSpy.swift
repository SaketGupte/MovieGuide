//
//  ListingPresenterSpy.swift
//  MovieGuide
//
//  Created by Saket Gupte on 25/05/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

@testable import MovieGuide
import Foundation

final class ListingPresenterImplSpy: ListingPresenter {
  var getMoviesCalled: Bool = false
  var getSortOptionsCalled: Bool = false
  var getDislikeMovieCalled: Bool = false
  
  func getListOfMoviesByDefaultOption() {
    getMoviesCalled = true
  }
  
  func getSortOptions() {
    getSortOptionsCalled = true
  }
  
  func getListOfMovie(option: MovieListOptions) {
    getMoviesCalled = true
  }
  
  func dislikeTappedForMovie(_ movie: ListViewModel) {
    getDislikeMovieCalled = true
  }
}
