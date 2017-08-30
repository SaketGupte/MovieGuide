//
//  DetailPresenter.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

protocol DetailPresenter {

  var interactor: DetailInteractor? {get set}
  var view: DetailView? {get set}
  
  func fetchMovieDetail(forMovieWithId movieId:Int)

  func dislikeMovie(movieId: Int)
}
