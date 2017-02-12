//
//  ListingPresenterImpl.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RxSwift

struct ListingPresenterImpl: ListingPresenter {

  var listingInteractor: ListingInteractor?
  var listingView: ListingView?
  let disposeBag = DisposeBag()

  func getListOfMoviesNowPlaying() {
    self.listingInteractor?
      .getListOfMoviesNowPlaying()
      .subscribe(onNext: {(movieResponse: ListingResponse) in
        self.showMoviesInView(movies: movieResponse.movie)
      })
      .addDisposableTo(disposeBag)
  }

  func getListOfPopularMovies() {
    self.listingInteractor?
      .getListOfPopularMovies()
      .subscribe(onNext: { (movies: [Movie]) in
        self.showMoviesInView(movies: movies)
      })
      .addDisposableTo(disposeBag)
  }

  func getListOfUpcomingMovies() {
    self.listingInteractor?
      .getListOfUpcomingMovies()
      .subscribe(onNext: { (movies: [Movie]) in
        self.showMoviesInView(movies: movies)
      })
      .addDisposableTo(disposeBag)
  }

  func getListOfTopRatedMovies() {
    self.listingInteractor?
      .getListOfTopRatedMovies()
      .subscribe(onNext: { (movies: [Movie]) in
        self.showMoviesInView(movies: movies)
      })
      .addDisposableTo(disposeBag)
  }

  internal func showMoviesInView(movies:[Movie]) {
    let moviesList = self.convertMoviesToMovieListViewModel(movies: movies)
    self.listingView?.showListOfMovie(movieList: moviesList)
  }

  internal func convertMoviesToMovieListViewModel(movies:[Movie]) -> [MovieListViewModel] {
    var movieModelList = [MovieListViewModel]()
    for movie in movies {
      let movieListViewModel:MovieListViewModel = MovieListViewModel(title: movie.title,
                                                                     posterURL:self.getPosterURl(posterPath: movie.posterPath))
      movieModelList.append(movieListViewModel)
    }
    return movieModelList
  }
  
  internal func getPosterURl(posterPath:String?) -> URL? {
    guard let posterPath = posterPath else { return nil }
    let completePosterPath =  constants.apiConstants.imageBaseUrl + constants.apiConstants.imageSize + posterPath
    return URL(string:completePosterPath)
  }

  internal func showErrorMessage() {
  }

}
