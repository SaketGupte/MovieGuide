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
}

private typealias Tests = ListingViewControllerTests

extension Tests {

  func testIfGetDefaultListIsCalled() {
    let listingPresenterImplSpy = ListingPresenterImplSpy()
    sut.listingPresenter = listingPresenterImplSpy
    
    XCTAssertNotNil(sut.view)
    
    XCTAssert(listingPresenterImplSpy.getMoviesCalled, "Should have called getListOfNowPlaying")
  }
  
  func testIfCollectionViewIsConnected() {
    XCTAssertNotNil(sut.view)
    
    XCTAssert(sut.collectionView != nil, "Collection view should have been connected at this point")
  }
  
  func testIfSortByButtonIsConnected() {
    XCTAssertNotNil(sut.view)
    
    XCTAssert(sut.sortByButton != nil, "Sort by button should have been connected")
  }
  
  func testSortButtonHasAction() {
    XCTAssertNotNil(sut.view)

    XCTAssert(sut.sortByButton.action! == #selector(sut.sortOptionsButtonTapped(_:)),"sort button should have an action link to sortOptionsButtonTapped")
  }
  
  func testGetSortOptionsInPresenterGetsCalledIfSortButtonIsTapped() {
    
    let listingPresenterImplSpy = ListingPresenterImplSpy()
    sut.listingPresenter = listingPresenterImplSpy

    XCTAssertNotNil(sut.view)
    
    sut.perform(sut.sortByButton.action!, with: UIControlEvents.touchUpInside)
        
    XCTAssertTrue(listingPresenterImplSpy.getSortOptionsCalled)
  }
  
  func testShouldDisplayFetchedMovies() {
    
    let collectionViewSpy = CollectionViewSpy()
    sut.collectionView = collectionViewSpy
    
    let dummyMovie = ListViewModel(id: 1, title: "Dummy Movie", posterURL: URL(string: "DummyURL"))
    
    sut.showListOfMovie(movieList: [dummyMovie])
    
    XCTAssert(collectionViewSpy.reloadDataCalled, "Displaying List of movies should reload data")
  }

  func testNumberOfSectionsInCollectionViewShouldAlwaysBeOne() {
    
    XCTAssertNotNil(sut.view)

    let collectionView = sut.collectionView
    
    let numberOfSections = sut.numberOfSections(in: collectionView!)
    
    XCTAssertEqual(numberOfSections, 1, "This should have been equal to 1")
  }
  
  func testNumberOfItemsInSectionShouldBeEqualToNumberOfMoviesFetched() {
    
    XCTAssertNotNil(sut.view)
    
    let dummyMovie = ListViewModel(id: 1, title: "Dummy Movie", posterURL: URL(string: "DummyURL"))
    
    sut.showListOfMovie(movieList: [dummyMovie])
    
    let collectionView = sut.collectionView
    
    let numberOfItems = sut.collectionView(collectionView!, numberOfItemsInSection: 0)
    
    XCTAssertEqual(numberOfItems, 1, "This should have been equal to 1")
  }
  
  func testShouldConfigureCellToDisplayOrder() {
    
    XCTAssertNotNil(sut.view)

    let dummyMovie = ListViewModel(id: 1, title: "Dummy Movie", posterURL: URL(string: "DummyURL"))

    sut.showListOfMovie(movieList: [dummyMovie])

    let collectionView = sut.collectionView

    let indexPath = IndexPath(item: 0, section: 0)
    
    let collectionViewCell = sut.collectionView(collectionView!, cellForItemAt: indexPath) as! ListingCollectionViewCell
    
    XCTAssertEqual(collectionViewCell.titleLabel.text, "Dummy Movie", "A properly configured collection view cell should display the movie name")
  }
    
}
