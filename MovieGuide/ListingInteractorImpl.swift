//
//  ListingInteractorImpl.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

import Moya
import Mapper
import Moya_ModelMapper
import RxOptional
import RxSwift

enum MovieListOptions: String {
  case nowPlaying = "now_playing"
  case popular = "popular"
  case topRated = "top_rated"
  case upcoming = "upcoming"
}

struct ListingInteractorImpl: ListingInteractor {

  var listingPresenter: ListingPresenter?
  
  let provider: RxMoyaProvider<MovieGuideEndpoint>
  
  init(provider: RxMoyaProvider<MovieGuideEndpoint> = OnlineProvider()) {
    self.provider = provider
  }
  
  func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse>  {
    
    return provider
      .request(MovieGuideEndpoint.movieByOption(option: listOption.rawValue))
      .mapObject(type: ListingResponse.self)
  }
}
