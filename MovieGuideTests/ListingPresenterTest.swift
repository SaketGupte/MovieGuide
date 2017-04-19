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
  
  var disposeBag = DisposeBag()
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func testIsGetListOfMoviesByDefaultOptionCalled() {
    let listingInteractorSpy = ListingInteractorSpy()
    
    listingInteractorSpy.getListOfMovies(listOption: .nowPlaying).subscribe(onNext: {(movieResponse: ListingResponse) in
     print(movieResponse)
    }).addDisposableTo(disposeBag)
    
    XCTAssertTrue(listingInteractorSpy.getListOfMoviesCalled, "Get list of movies should have been called")
  }
  
  class ListingInteractorSpy: ListingInteractor {
    
    var getListOfMoviesCalled = false

    let provider: RxMoyaProvider<MovieGuideEndpoint> = RxMoyaProvider<MovieGuideEndpoint>(endpointClosure:MoyaProvider.defaultEndpointMapping,
                                                                                          stubClosure: MoyaProvider.immediatelyStub)
    
    

    func getListOfMovies(listOption: MovieListOptions) -> Observable<ListingResponse> {
      getListOfMoviesCalled = true
      return provider.request(MovieGuideEndpoint.movieByOption(option: listOption.rawValue)).mapObject(type: ListingResponse.self)
    }
  }
  
  
}
