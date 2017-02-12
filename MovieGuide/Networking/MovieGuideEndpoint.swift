//
//  File.swift
//  MovieGuide
//
//  Created by Saket Gupte on 12/29/16.
//  Copyright © 2016 Saket Gupte. All rights reserved.
//

import Foundation
import Moya

enum MovieGuideEndpoint {
  case movieDetails(movieId: String)
  case similarMovies(movieId: String)
  case imagesForMovie(movieId: String)
  case movieByOption(option: String)
}

extension MovieGuideEndpoint: TargetType {

  var baseURL: URL { return NSURL(string: "https://api.themoviedb.org/3/movie/")! as URL}

  var path: String {
    switch self {
    case .movieDetails(let movieId):
      return "\(movieId)"
    case .similarMovies(let movieId):
      return "\(movieId)/similar"
    case .imagesForMovie(let movieId):
      return "\(movieId)/images"
    case .movieByOption(let option):
      return "\(option)"

    }
  }

  var method: Moya.Method {
    return .get
  }

  var parameters: [String: Any]? {
    return ["api_key" : "351b0c062737790ac9075594a0a74191"]
  }

  var sampleData: Data {
    switch self {
    case .movieDetails(_):
      return stubbedResponse("MovieDetails")
    case .similarMovies(_):
      return stubbedResponse("SimilarMovies")
    case .imagesForMovie(_):
      return stubbedResponse("imageForMovies")
    case .movieByOption(_):
      return stubbedResponse("MoviesByOption")
    }
  }

  var task: Task {
    return .request
  }
}

func stubbedResponse(_ filename: String) -> Data! {
  @objc class TestClass: NSObject { }

  let bundle = Bundle(for: TestClass.self)
  let path = bundle.path(forResource: filename, ofType: "json")
  return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
