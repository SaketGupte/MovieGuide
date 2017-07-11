//
//  StubbedListingDependency.swift
//  MovieGuide
//
//  Created by Saket Gupte on 10/07/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

@testable import MovieGuide

import Foundation
import Moya
import RxSwift

enum StubbedResponse {
  case success
  case error
}

extension StubbedResponse {

  func getListingDependency(forTarget target: MovieGuideEndpoint) -> ListingDependency {

    var endpointClosure: MoyaProvider<MovieGuideEndpoint>.EndpointClosure?

    switch self {
    case .success:
      endpointClosure = getEndpointClosureWithSuccessResponse(target)
    case .error:
      endpointClosure = getEndpointClosureWithFailureResponse(target)
    }

    let provider: OnlineProvider<MovieGuideEndpoint> = OnlineProvider(endpointClosure: endpointClosure!,
                                                                      stubClosure: MoyaProvider.immediatelyStub,
                                                                      online: Observable.just(true))

    return ListingDependency(networkProvider: provider, storageProvider: LocalStorageSpy())
  }

  fileprivate func getEndpointClosureWithSuccessResponse(_ target: MovieGuideEndpoint) -> MoyaProvider<MovieGuideEndpoint>.EndpointClosure {
    return { (target: MovieGuideEndpoint) -> Endpoint<MovieGuideEndpoint> in
      let url = target.baseURL.appendingPathComponent(target.path).absoluteString
      return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    }
  }

  fileprivate func getEndpointClosureWithFailureResponse(_ target: MovieGuideEndpoint) -> MoyaProvider<MovieGuideEndpoint>.EndpointClosure {
    return { (target: MovieGuideEndpoint) -> Endpoint<MovieGuideEndpoint> in
      let error: NSError = NSError(domain: "com.movieguide", code: 400, userInfo: nil)
      let url = target.baseURL.appendingPathComponent(target.path).absoluteString
      return Endpoint(url: url, sampleResponseClosure: {.networkError(error)}, method: target.method, parameters: target.parameters)
    }
  }

}
