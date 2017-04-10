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

  func getListOfMovies(sortOption: String) {
  }
  
  func getListOfMoviesByDefaultOption() {
    getListOfMovie(option: .nowPlaying)
  }
  
  func getSortOptions() {
    listingView?.showSortOptions([("Now Playing", .nowPlaying), ("Popular", .popular), ("Upcoming", .upcoming), ("Top Rated", .topRated)])
  }
  
  func getListOfMovie(option: MovieListOptions) {
    listingInteractor?
      .getListOfMovies(listOption: option)
      .subscribe(onNext: { (movieResponse: ListingResponse) in
        self.showMoviesInView(movies: movieResponse.movie)
      })
      .addDisposableTo(disposeBag)
  }
  
  func showMoviesInView(movies:[Movie]) {
    let moviesList = convertMoviesToMovieListViewModel(movies: movies)
    listingView?.showListOfMovie(movieList: moviesList)
  }

  fileprivate func convertMoviesToMovieListViewModel(movies:[Movie]) -> [ListViewModel] {
    var movieList = [ListViewModel]()
    for movie in movies {
      let listViewModel:ListViewModel = ListViewModel(title: movie.title,
                                                      posterURL:getPosterURl(posterPath: movie.posterPath))
      movieList.append(listViewModel)
    }
    return movieList
  }
  
  fileprivate func getPosterURl(posterPath:String?) -> URL? {
    guard let posterPath = posterPath else { return nil }
    let completePosterPath =  constants.apiConstants.imageBaseUrl + constants.apiConstants.imageSize + posterPath
    return URL(string:completePosterPath)
  }

  func showErrorMessage() {
  }

}
