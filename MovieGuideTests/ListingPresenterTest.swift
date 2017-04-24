//
//  ListingPresenterTest.swift
//  MovieGuide
//
//  Created by Saket Gupte on 16/04/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

@testable import MovieGuide
import XCTest
import RxSwift
import RxTest
import Moya
import Moya_ModelMapper

class ListingPresenterTest: XCTestCase {
  
  var sut: ListingPresenterImpl!
  var disposeBag = DisposeBag()
  
  override func setUp() {
    super.setUp()
    sut = ListingPresenterImpl()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testIsGetListOfMoviesByDefaultOptionCalled() {
    
    let provider:OnlineProvider<MovieGuideEndpoint> = OnlineProvider(stubClosure: MoyaProvider.immediatelyStub, online:Observable.just(true))
    
    let interactorSpy = ListingInteractorSpy(provider: provider)
    sut.listingInteractor = interactorSpy
    sut.getListOfMoviesByDefaultOption()
    XCTAssert(interactorSpy.getListOfMoviesCalled, "Get list of movies not called")
  }
  
  func testIsShowSortOptionsCalled() {
  }
  
  func testAreCorrectSortOptionsReturned() {
  }
  
  func testIsShowListOfMoviesCalled() {
  }
  
  func testIsListMoviesObjectProvidedToShowMoviesMethod() {
  }
  
  func testShowErrorGetsCalledForNetworkFailures() {
  }
  
  class ListingViewSpy: ListingView {
    
    var showErrorMessageCalled = false
    var showListOfMovieCalled = false
    var showSortOptionsCalled = false
    
    func showErrorMessage(_ message: String) {
      showErrorMessageCalled = true
    }
    
    func showListOfMovie(movieList: [ListViewModel]) {
      showListOfMovieCalled = true
    }
    
    func showSortOptions(_ sortList: [(String, MovieListOptions)]) {
      showSortOptionsCalled = true
    }
  }
  
  class ListingInteractorSpy: ListingInteractor {
    
    var provider: RxMoyaProvider<MovieGuideEndpoint>
    var getListOfMoviesCalled: Bool = false
    
    init(provider: RxMoyaProvider<MovieGuideEndpoint>) {
      self.provider = provider
    }
    
    func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse> {
      getListOfMoviesCalled = true
      
      return provider
        .request(MovieGuideEndpoint.movieByOption(option: listOption.rawValue))
        .mapObject(type: ListingResponse.self)
    }
  }
  
  
}
