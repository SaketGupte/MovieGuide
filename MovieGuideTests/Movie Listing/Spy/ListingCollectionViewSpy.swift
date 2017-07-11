//
//  ListingCollectionViewSpy.swift
//  MovieGuide
//
//  Created by Saket Gupte on 25/05/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

@testable import MovieGuide

import UIKit

final class CollectionViewSpy: UICollectionView {
  
  var reloadDataCalled = false
  
  override func reloadData() {
    reloadDataCalled = true
  }

  init() {
    super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
  }

  // Forced implementation of coder
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) should not be called")
  }

}
