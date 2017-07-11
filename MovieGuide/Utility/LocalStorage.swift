//
//  LocalStorage.swift
//  MovieGuide
//
//  Created by Saket Gupte on 01/05/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import RealmSwift


protocol LocalStorage {
  
  func addMovieToDislikeList(movieId: Int)
  
  func getAllDislikedMovies() -> [DislikedMovie]
}

class LocalStorageImpl: LocalStorage {
  
  lazy var realm: Realm? = try? Realm()
  
  func addMovieToDislikeList(movieId: Int) {
    let dislikedMovies = DislikedMovie(value: [movieId])
    
    DispatchQueue.global(qos: .utility).async {
      try? self.realm?.write {() -> Void in
        self.realm?.add(dislikedMovies)
      }
    }
    
  }
  
  
  func getAllDislikedMovies() -> [DislikedMovie] {
    let dislikedMoviesResults =  realm?.objects(DislikedMovie.self)
    
    guard let results = dislikedMoviesResults else {
      return []
    }
    return Array(results)
  }
}
