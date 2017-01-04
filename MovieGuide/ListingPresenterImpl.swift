//
//  ListingPresenterImpl.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RxSwift

class ListingPresenterImpl: ListingPresenter {

  var listingInteractor: ListingInteractor?
  var listingView: ListingView?
  let disposeBag = DisposeBag()

  func getListOfMoviesNowPlaying() {
    self.listingInteractor?
      .getListOfPopularMovies()
      .subscribe(onNext: { [weak self] (movies: [Movie]) in
        self?.showMoviesInView(movies: movies)
      })
      .addDisposableTo(disposeBag)
  }

  func getListOfPopularMovies() {
    self.listingInteractor?
      .getListOfTopRatedMovies()
      .subscribe(onNext: { [weak self] (movies: [Movie]) in
      self?.showMoviesInView(movies: movies)
      })
      .addDisposableTo(disposeBag)
  }

  func getListOfUpcomingMovies() {
    self.listingInteractor?.getListOfMoviesNowPlaying()
      .subscribe(onNext: { [weak self] (movies: [Movie]) in
        self?.showMoviesInView(movies: movies)
      })
      .addDisposableTo(disposeBag)
  }

  func getListOfTopRatedMovies() {
    self.listingInteractor?.getListOfUpcomingMovies()
      .subscribe(onNext: { [weak self] (movies: [Movie]) in
        self?.showMoviesInView(movies: movies)
      })
      .addDisposableTo(disposeBag)
  }

  internal func showMoviesInView(movies:[Movie]) {
    let moviesList = self.convertMoviesToMovieListModel(movies: movies)
    self.listingView?.showListOfMovie(movieList: moviesList)
  }

  internal func convertMoviesToMovieListModel(movies:[Movie]) -> [MovieListModel] {
    return []
  }

  internal func showErrorMessage() {
  }

}
