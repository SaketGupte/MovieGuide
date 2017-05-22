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
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
  
  func testIsGetListOfMoviesByDefaultOptionCalled() {
    
    let listingDependency = getListingDependencies()
    
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
    
    let successEndpointClosure = getEndpointClosureWithSuccessResponse(target: MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
    configureSutWithInteractorSpy(forEndpointClosure: successEndpointClosure)
    
    //When
    sut.getListOfMoviesByDefaultOption()
    
    //Then
    XCTAssertTrue(viewControllerSpy.showListOfMovieCalled, "show list of movies is not called")
  }
  
  func testIsArrayPassedToShowMovieContainsObjectsKindOfListViewModel() {
    //Given
    let viewControllerSpy = ListingViewSpy()
    sut.listingView = viewControllerSpy
    
    let successEndpointClosure = getEndpointClosureWithSuccessResponse(target: MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
    configureSutWithInteractorSpy(forEndpointClosure: successEndpointClosure)
    
    //When
    sut.getListOfMoviesByDefaultOption()
    
    //Then
    XCTAssertTrue(viewControllerSpy.listOfMovies[0] is ListViewModel, "List view model type object not passed")
  }
  
  func testShowErrorGetsCalledForNetworkFailures() {
    //Given
    let viewControllerSpy = ListingViewSpy()
    sut.listingView = viewControllerSpy
    
    let failureEndpointClosure = getEndpointClosureWithFailureResponse(target: MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
    configureSutWithInteractorSpy(forEndpointClosure: failureEndpointClosure)
    
    // When
    sut.getListOfMoviesByDefaultOption()
    
    // Then
    XCTAssertTrue(viewControllerSpy.showErrorMessageCalled, "show error is not called")
  }
  
  //Mark: Private convinence methods
  
  fileprivate func getEndpointClosureWithSuccessResponse(target: MovieGuideEndpoint) -> MoyaProvider<MovieGuideEndpoint>.EndpointClosure {
    return { (target: MovieGuideEndpoint) -> Endpoint<MovieGuideEndpoint> in
      let url = target.baseURL.appendingPathComponent(target.path).absoluteString
      return Endpoint(url: url, sampleResponseClosure: {.networkResponse(200, target.sampleData)}, method: target.method, parameters: target.parameters)
    }
  }
  
  fileprivate func getEndpointClosureWithFailureResponse(target: MovieGuideEndpoint) -> MoyaProvider<MovieGuideEndpoint>.EndpointClosure {
    return { (target: MovieGuideEndpoint) -> Endpoint<MovieGuideEndpoint> in
      let error: NSError = NSError(domain: "com.movieguide", code: 400, userInfo: nil)
      let url = target.baseURL.appendingPathComponent(target.path).absoluteString
      return Endpoint(url: url, sampleResponseClosure: {.networkError(error)}, method: target.method, parameters: target.parameters)
    }
  }
  
  fileprivate func getListingDependencies(endpointClosure: @escaping MoyaProvider<MovieGuideEndpoint>.EndpointClosure = MoyaProvider.defaultEndpointMapping) -> ListingDependency {
    let provider:OnlineProvider<MovieGuideEndpoint> = OnlineProvider(endpointClosure: endpointClosure,
                                                                     stubClosure: MoyaProvider.immediatelyStub,
                                                                     online:Observable.just(true))
    return ListingDependency(onlineProvider: provider)
  }
  
  fileprivate func configureSutWithInteractorSpy(forEndpointClosure endpointClosure: @escaping MoyaProvider<MovieGuideEndpoint>.EndpointClosure) {
    let listingDependency = getListingDependencies(endpointClosure: endpointClosure)
    let interactorSpy = ListingInteractorSpy(dependencies: listingDependency)
    sut.listingInteractor = interactorSpy
  }
  
  //Mark: Spy

  class ListingInteractorSpy: ListingInteractor {
    
    var provider: OnlineProvider<MovieGuideEndpoint> {
      get {
        return dependencies.onlineProvider
      }
    }
    
    var dependencies: ListingInteractor.Dependencies
    
    var getListOfMoviesCalled: Bool = false
    
    init(dependencies: ListingInteractor.Dependencies) {
      self.dependencies = dependencies
    }
    
    func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse> {
      getListOfMoviesCalled = true
      
      let endpoint: Endpoint = dependencies
        .onlineProvider
        .endpoint(MovieGuideEndpoint.movieByOption(option: MovieListOptions.nowPlaying.rawValue))
      
      let result = getSampleResposeForEndpoint(endpoint)
      return Observable<ListingResponse>.create { (observer) -> Disposable in
        switch result {
        case let .success(response):
          observer.onNext(try! response.mapObject() as ListingResponse)
        case let .failure(error):
          observer.onError(error)
        }
        return Disposables.create()
      }
    }
    
    func getSampleResposeForEndpoint(_ endpoint: Endpoint<MovieGuideEndpoint>) -> Result<Moya.Response, MoyaError> {
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
  }
  
  class ListingViewSpy: ListingView {
    
    var showErrorMessageCalled = false
    var showListOfMovieCalled = false
    var showSortOptionsCalled = false
    
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
  }
  
}
