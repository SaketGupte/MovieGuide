//
//  ListingView.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/4/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

protocol ListingView {

  func showListOfMovie(movieList : [ListViewModel])

  func showSortOptions(_ sortList:[(String, MovieListOptions)])
  
  func showErrorMessage(_ message: String)
}
