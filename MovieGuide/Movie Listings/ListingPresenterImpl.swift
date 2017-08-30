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
  var moviesList: [ListViewModel] = []

  func getListOfMoviesByDefaultOption() {
    getListOfMovie(option: .nowPlaying)
  }
  
  func getSortOptions() {
    listingView?.showSortOptions([("Now Playing", .nowPlaying), ("Popular", .popular), ("Upcoming", .upcoming), ("Top Rated", .topRated)])
  }
  
  func getListOfMovie(option: MovieListOptions) {
    listingInteractor?
      .getListOfMovies(listOption: option)
      .subscribe(onNext: { movies in
        self.showMoviesInView(movies: movies)
      }, onError: { error in
        self.showErrorMessage(error)
      })
      .addDisposableTo(disposeBag)
  }
  
  func dislikeTappedForMovie(_ movie: ListViewModel) {
    listingInteractor?.removeMovieFromListing(movieId: movie.id)
    updateListOfMoviesByRemoving(movie)
    listingView?.showToastAndUpdateDisplayedMovies(message: "Movie has been removed", movieList: moviesList)
  }
  
  fileprivate func updateListOfMoviesByRemoving(_ movie: ListViewModel) {
    moviesList = moviesList.filter() { $0 != movie }
  }
  
  fileprivate func showMoviesInView(movies:[Movie]) {
    moviesList = convertMoviesToMovieListViewModel(movies: movies)
    listingView?.showListOfMovie(movieList: moviesList)
  }

  fileprivate func showErrorMessage(_ error: Error) {
    listingView?.showErrorMessage(error.localizedDescription)
  }
  
  fileprivate func convertMoviesToMovieListViewModel(movies:[Movie]) -> [ListViewModel] {
    var movieList = [ListViewModel]()
    for movie in movies {
      let listViewModel:ListViewModel = ListViewModel(id: movie.id,
                                                      title: movie.title,
                                                      posterURL:movie.posterURL)
      movieList.append(listViewModel)
    }
    return movieList
  }

  func showErrorMessage() {
  }

}
