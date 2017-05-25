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
  let disposeBag = DisposeBag()
  
  let scheduler = TestScheduler(initialClock: 0)
  
  
  override func setUp() {
    super.setUp()
    
    let listingDependency = ListingDependency()
    sut = ListingInteractorImpl(dependencies: listingDependency)
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testIsListingResponseReturnedWhenGetMoviesCallIsSuccessful() {
    
    let expectation1 = expectation(description: "Call was successful")
    let observer = scheduler.createObserver([Movie].self)
    
    let response = sut.getListOfMovies(listOption: .nowPlaying)
    
    response.subscribe(onNext: { _ in
      expectation1.fulfill()
    }).addDisposableTo(disposeBag)

    response.subscribe(observer).addDisposableTo(disposeBag)
    
    scheduler.start()
    
    waitForExpectations(timeout: 5.0) { error in
      XCTAssertTrue(error == nil)
      XCTAssertEqual(observer.events.count, 2)
    }
  }
  
  
}
