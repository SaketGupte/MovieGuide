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
import Moya
import Result
import Moya_ModelMapper

class ListingPresenterTest: XCTestCase {
  
  var sut: ListingPresenterImpl!
  
  override func setUp() {
    super.setUp()
    sut = ListingPresenterImpl()
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
}

private typealias Tests = ListingPresenterTest

extension Tests {

  func testIsGetListOfMoviesByDefaultOptionCalled() {
    
    let listingDependency = StubbedResponse.success.getListingDependency(forTarget: MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))

    let interactorSpy = ListingInteractorSpy(dependencies: listingDependency)
    sut.listingInteractor = interactorSpy
    sut.getListOfMoviesByDefaultOption()
    XCTAssertTrue(interactorSpy.getListOfMoviesCalled, "Get list of movies not called")
  }
  
  func testIsShowSortOptionsCalled() {
    let viewControllerSpy = ListingViewSpy()
    
    sut.listingView = viewControllerSpy
    sut.getSortOptions()
    XCTAssertTrue(viewControllerSpy.showSortOptionsCalled, "Get sort options was not called")
  }
  
  func testAreCorrectSortOptionsReturned() {
    let viewControllerSpy = ListingViewSpy()
    
    sut.listingView = viewControllerSpy
    sut.getSortOptions()
    XCTAssertEqual(viewControllerSpy.sortOptions.count, 4, "Incorrect number of sort options returned")
    XCTAssertEqual(viewControllerSpy.sortOptions[2].0 , "Upcoming", "")
  }
  
  func testIsShowListOfMoviesCalled() {
    //Given
    let viewControllerSpy = ListingViewSpy()
    sut.listingView = viewControllerSpy
    
    configureSutWithInteractorSpy(forResponseType: .success)

    //When
    sut.getListOfMoviesByDefaultOption()
    
    //Then
    XCTAssertTrue(viewControllerSpy.showListOfMovieCalled, "show list of movies is not called")
  }
  
  func testIsArrayPassedToShowMovieContainsObjectsKindOfListViewModel() {
    //Given
    let viewControllerSpy = ListingViewSpy()
    sut.listingView = viewControllerSpy
    
    configureSutWithInteractorSpy(forResponseType: .success)
    
    //When
    sut.getListOfMoviesByDefaultOption()
    
    //Then
    XCTAssertTrue(viewControllerSpy.listOfMovies[0] is ListViewModel, "List view model type object not passed")
  }
  
  func testShowErrorGetsCalledForNetworkFailures() {
    //Given
    let viewControllerSpy = ListingViewSpy()
    sut.listingView = viewControllerSpy
    
    configureSutWithInteractorSpy(forResponseType: .error)
    
    // When
    sut.getListOfMoviesByDefaultOption()
    
    // Then
    XCTAssertTrue(viewControllerSpy.showErrorMessageCalled, "show error is not called")
  }
}

private typealias InteractorSpy = ListingPresenterTest

extension InteractorSpy {
  //Mark: Private convinence methods
  
  fileprivate func configureSutWithInteractorSpy(forResponseType responseType: StubbedResponse) {
    let listingDependency = responseType.getListingDependency(forTarget: MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
    let interactorSpy = ListingInteractorSpy(dependencies: listingDependency)
    sut.listingInteractor = interactorSpy
  }
  
  //Mark: Spy

  class ListingInteractorSpy: ListingInteractor {
    
    var networkProvider: OnlineProvider<MovieGuideEndpoint> {
      get {
        return dependencies.networkProvider
      }
    }
    
    var storageProvider: LocalStorage {
      get {
        return dependencies.storageProvider
      }
    }
    
    var dependencies: ListingInteractor.Dependencies
    
    var getListOfMoviesCalled: Bool = false
    var removeMoviesCalled: Bool = false
    
    init(dependencies: ListingInteractor.Dependencies) {
      self.dependencies = dependencies
    }
    
    func getListOfMovies(listOption: MovieListOptions) -> Observable<[Movie]> {
      getListOfMoviesCalled = true
      
      let endpoint: Endpoint = dependencies
        .networkProvider
        .endpoint(MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
      
      let result = getSampleResposeForEndpoint(endpoint)
      
      let response = Observable<ListingResponse>.create { (observer) -> Disposable in
        switch result {
        case let .success(response):
          observer.onNext(try! response.mapObject() as ListingResponse)
        case let .failure(error):
          observer.onError(error)
        }
        return Disposables.create()
      }
      
      return response.map { (listingResponse)  in
        listingResponse.movies.flatMap {$0}
      }
    }
    
    fileprivate func getSampleResposeForEndpoint(_ endpoint: Endpoint<MovieGuideEndpoint>) -> Result<Moya.Response, MoyaError> {
      switch endpoint.sampleResponseClosure() {
      case .networkResponse(let statusCode, let data):
        let response = Moya.Response(statusCode: statusCode, data: data)
        return .success(response)
      case .networkError(let error) :
        let error = MoyaError.underlying(error)
        return .failure(error)
      case .response(let response, let data):
        let response = Moya.Response(statusCode: response.statusCode, data: data)
        return .success(response)
      }
    }
    
    func removeMovieFromListing(movieId: Int) {
      removeMoviesCalled = true
    }
    
  }
}

private typealias ListingViewSpy = ListingPresenterTest

extension ListingViewSpy {

  class ListingViewSpy: ListingView {
    
    var showErrorMessageCalled = false
    var showListOfMovieCalled = false
    var showSortOptionsCalled = false
    var showToastAndUpdateDisplayedMoviesCalled = false
    
    var listOfMovies = [Any]()
    
    var sortOptions: [(String, MovieListOptions)] = []
    
    func showErrorMessage(_ message: String) {
      showErrorMessageCalled = true
    }
    
    func showListOfMovie(movieList: [ListViewModel]) {
      showListOfMovieCalled = true
      listOfMovies = movieList
    }
    
    func showSortOptions(_ sortList: [(String, MovieListOptions)]) {
      showSortOptionsCalled = true
      sortOptions = sortList
    }
    
    func showToastAndUpdateDisplayedMovies(message: String, movieList: [ListViewModel]) {
      showToastAndUpdateDisplayedMoviesCalled = true
    }
  }

}
