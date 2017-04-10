//
//  ListingViewControllerTests.swift
//  MovieGuide
//
//  Created by Saket Gupte on 05/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

@testable import MovieGuide
import XCTest

class ListingViewControllerTests: XCTestCase
{
  var sut: ListingViewController!
  
  override func setUp() {
    super.setUp()
    setupListingViewController()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  func setupListingViewController() {
    let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    sut = storyboard.instantiateViewController(withIdentifier: "ListingViewController") as! ListingViewController
  }
  
  func testIfGetListOfMoviesNowPlayingIsCalled() {
    let listingPresenterImplSpy = ListingPresenterImplSpy()
    sut.listingPresenter = listingPresenterImplSpy
    
    XCTAssertNotNil(sut.view)
    
    XCTAssert(listingPresenterImplSpy.getMoviesCalled, "Should have called getListOfNowPlaying")
  }
  
  class ListingPresenterImplSpy:ListingPresenter {
    var getMoviesCalled = false
    
    func getListOfPopularMovies() {
      getMoviesCalled = true
    }
    
    func getListOfTopRatedMovies() {
      getMoviesCalled = true
    }
    
    func getListOfUpcomingMovies() {
      getMoviesCalled = true
    }
    
    func getListOfMoviesNowPlaying() {
      getMoviesCalled = true
    }
  }
  
}
