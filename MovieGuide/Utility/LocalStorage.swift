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
  
  func getAllDislikedMovies() -> [DislikedMovies]
}

class LocalStorageImpl: LocalStorage {
  
  lazy var realm: Realm? = try? Realm()
  
  func addMovieToDislikeList(movieId: Int) {
    let dislikedMovies = DislikedMovies(value: [movieId])
    
    DispatchQueue.global(qos: .utility).async {
      try? self.realm?.write {() -> Void in
        self.realm?.add(dislikedMovies)
      }
    }
    
  }
  
  
  func getAllDislikedMovies() -> [DislikedMovies] {
    let dislikedMoviesResults =  realm?.objects(DislikedMovies.self)
    
    guard let results = dislikedMoviesResults else {
      return []
    }
    return Array(results)
  }
}
