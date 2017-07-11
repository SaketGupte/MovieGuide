//
//  ListingInteractorTest.swift
//  MovieGuide
//
//  Created by Saket Gupte on 29/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

@testable import MovieGuide
import XCTest
import RxSwift
import RxTest
import Moya

class ListingInteractorTest: XCTestCase {
  var sut: ListingInteractor!
  var scheduler: TestScheduler!
  var disposeBag: DisposeBag!

  override func setUp() {
    super.setUp()

    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
    let listingDependency = StubbedResponse.success.getListingDependency(forTarget: MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
    sut = ListingInteractorImpl(dependencies: listingDependency)
  }
  
  override func tearDown() {
    sut = nil
    scheduler = nil
    disposeBag = nil
    super.tearDown()
  }
  
  func testIsListingResponseReturnedWhenGetMoviesCallIsSuccessful() {
    
    let testExpectation = expectation(description: "Call was successful")
    let observer = scheduler.createObserver([Movie].self)
    
    let response = sut.getListOfMovies(listOption: .nowPlaying).shareReplay(1)
    
    response.subscribe(onCompleted: {
      testExpectation.fulfill()
    }).addDisposableTo(disposeBag)

    response.subscribe(observer).addDisposableTo(self.disposeBag)

    scheduler.start()
    
    waitForExpectations(timeout: 1.0) { error in
      XCTAssertTrue(error == nil)
      XCTAssertEqual(observer.events.count, 2)
    }
    
  }
  
  
}
