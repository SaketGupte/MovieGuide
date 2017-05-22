//
//  MovieListModel.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/3/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

struct ListViewModel {
  let id: Int
  let title: String
  let posterURL : URL?

  init(id: Int, title: String, posterURL: URL?) {
    self.id = id
    self.title = title
    self.posterURL = posterURL
  }
}

extension ListViewModel: Equatable {
  
  static func ==(lhs: ListViewModel, rhs: ListViewModel) -> Bool {
    return lhs.id == rhs.id
  }

}
