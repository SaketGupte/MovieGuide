//
//  ListingView.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController,
                             UICollectionViewDataSource,
                             UICollectionViewDelegate,
                             ListingView {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var sortByButton: UIButton!

  var movies:[MovieListViewModel] = []
  var listingPresenter: ListingPresenter?

  override func viewDidLoad() {
    super.viewDidLoad()

    self.collectionView.register(ListingCollectionViewCell.self)
    self.getMovies()
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let listingCell:ListingCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    listingCell.configure(movie: movies[indexPath.row])
    return listingCell
  }
  
  func showListOfMovie(movieList: [MovieListViewModel]) {
    self.movies = movieList
    self.collectionView.reloadData()
  }

  func getMovies() {
    self.listingPresenter?.getListOfMoviesNowPlaying()
  }
}
