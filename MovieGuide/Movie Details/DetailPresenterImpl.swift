//
//  DetailPresenterImpl.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RxSwift

struct DetailPresenterImpl: DetailPresenter {

  var interactor: DetailInteractor?
  var view: DetailView?
  let disposeBag = DisposeBag()

  func dislikeMovie(movieId: Int) {
  }

  func fetchMovieDetail(forMovieWithId movieId: Int) {
    interactor?
      .getDetailsForMovie(withId: movieId)
      .subscribe(onNext: { movie in
        self.displayMovie(movie)
      }, onError: { error in
        self.displayError(error)
      }).addDisposableTo(disposeBag)
  }

  func displayError(_ error: Error) {
    view?.showErrorView(withErrorMessage: error.localizedDescription)
  }

  func displayMovie(_ movie: Movie) {
    let detailViewModel: DetailViewModel = convertToViewModel(movie: movie)
    view?.showMovieDetails(movie: detailViewModel)
  }

  fileprivate func convertToViewModel(movie: Movie) -> DetailViewModel {

    return DetailViewModel(movieId: movie.id,
                           title: movie.title,
                           ageGroup: getAgeGroup(isAdultMovie: movie.isAdultMovie),
                           runningTime: getRunningTime(movieLength: movie.runningTime),
                           genres: getGenreList(genres: movie.genres),
                           isRated: movie.rating != nil,
                           rating: getMovieRating(movieRating: movie.rating),
                           votesReceived: getVotesRecieved(votes: movie.votesReceived),
                           overview: movie.overview,
                           backgroundImageURL: movie.backdropURL,
                           posterImageURL: movie.posterURL)
  }

  fileprivate func getAgeGroup(isAdultMovie: Bool?) -> String? {
    guard isAdultMovie != nil else {
      return nil
    }

    return isAdultMovie! ? "A" : "UA"
  }

  fileprivate func getRunningTime(movieLength: Int?) -> String? {

    guard let movieLength = movieLength else {
      return nil
    }

    return "\(movieLength/60)h \(movieLength%60)min"
  }

  fileprivate func getGenreList(genres: [Genre]?) -> String? {

    guard let genres = genres else {
      return nil
    }

    return genres.flatMap({$0.name}).joined(separator:", ")
  }

  fileprivate func getVotesRecieved(votes: Int?) -> String? {

    guard let votes = votes else {
      return nil
    }

    return "\(votes)"
  }

  fileprivate func getMovieRating(movieRating: Double?) -> String? {

    guard let movieRating = movieRating else {
      return nil
    }

    return "\(movieRating)/10"
  }


}
