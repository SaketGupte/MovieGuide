//
//  Networking.swift
//  MovieGuide
//
//  Created by Saket Gupte on 19/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//
//  OnlineProvider is copy of OnlineProvider used in Eidolon

import Foundation
import Moya
import RxSwift
import ReachabilitySwift
  
final class OnlineProvider<Target> : RxMoyaProvider<Target> where Target: TargetType {
  
  fileprivate let online: Observable<Bool>
  
  init(endpointClosure: @escaping EndpointClosure = MoyaProvider.defaultEndpointMapping,
       requestClosure: @escaping RequestClosure = MoyaProvider.defaultRequestMapping,
       stubClosure: @escaping StubClosure =  MoyaProvider.neverStub,
       online: Observable<Bool> = connectedToInternetOrStubbing()) {
    self.online = online
    super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure)
  }
  
  override func request(_ token: Target) -> Observable<Moya.Response> {
    let actualRequest = super.request(token)
    return online.ignore(value: false).take(1).flatMap { _ in // Turn the online state into a network request
      return actualRequest
    }
  }
  
}

//Mark - Reachability

private let reachabilityManager = ReachabilityManager()

func connectedToInternetOrStubbing() -> Observable<Bool> {
  let stubbing: Observable<Bool> = Observable.just(APIKeys.sharedKeys.stubResponse)
  
  guard let online = reachabilityManager?.reach else {
    return stubbing
  }
  
  return [online, stubbing].combineLatestOr()
}


private class ReachabilityManager {
  
  private let reachability: Reachability
  
  let _reach = ReplaySubject<Bool>.create(bufferSize: 1)
  var reach: Observable<Bool> {
    return _reach.asObservable()
  }
  
  init?() {
    guard let r = Reachability() else {
      return nil
    }
    
    self.reachability = r
    
    do {
      try self.reachability.startNotifier()
    }
    catch {
      return nil
    }
    
    self._reach.onNext(self.reachability.isReachable)
    
    self.reachability.whenReachable = { _ in
      DispatchQueue.main.async {self._reach.onNext(true)}
    }
    
    self.reachability.whenUnreachable = { _ in
      DispatchQueue.main.async {self._reach.onNext(false)}
    }
  }
  
  deinit {
    self.reachability.stopNotifier()
  }
}
