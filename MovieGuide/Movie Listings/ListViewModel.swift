//
//  MovieListModel.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/3/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

struct ListViewModel {
  let title: String
  let posterURL : URL?

  init(title: String, posterURL: URL?) {
    self.title = title
    self.posterURL = posterURL
  }
}
