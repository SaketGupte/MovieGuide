//
//  ListingView.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/2/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController,
                             ListingView {

  @IBOutlet weak var collectionView: UICollectionView!
  var sortPicker: CustomPicker!
  
  var movies:[ListViewModel] = []
  var sortOptions:[(description: String, value: MovieListOptions)] = []
  var listingPresenter: ListingPresenter?

  init() {
    super.init(nibName: nil, bundle: nil)
    ListingConfigurator.configure(viewController: self)
    configureNavigationBar()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not implemented for ListingViewController")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.register(ListingCollectionViewCell.self)
    getMoviesOnLoad()
  }
  
  @objc func sortOptionsButtonTapped() {
    listingPresenter?.getSortOptions()
  }
  
  func showListOfMovie(movieList: [ListViewModel]) {
    movies = movieList
    collectionView.reloadData()
  }
  
  func showSortOptions(_ sortList: [(String, MovieListOptions)]) {
    
    sortOptions = sortList
    sortPicker = CustomPicker(title: "Sort Option", items: sortOptions.map { $0.description })
    sortPicker.delegate = self
    sortPicker.presentPickerOnView(view: self.view)
  }
  
  func showErrorMessage(_ message: String) {
    print("Unable to fetch list of movies")
  }
  
  func showToastAndUpdateDisplayedMovies(message: String, movieList: [ListViewModel]) {
    print(message)
    movies = movieList
    collectionView.reloadData()
  }
  
  func getMoviesOnLoad() {
    listingPresenter?.getListOfMoviesByDefaultOption()
  }
  
  func removeDislikedMovieFromDisplayList(movie: ListViewModel) {
    listingPresenter?.dislikeTappedForMovie(movie)
  }

  func configureNavigationBar() {
    title = "Movies"
    let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "sort"), style: .plain, target: self, action: #selector(sortOptionsButtonTapped))
    self.navigationItem.rightBarButtonItem = leftBarButtonItem
  }
}


extension ListingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let listingCell:ListingCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
    listingCell.configure(movie: movies[indexPath.row])
    listingCell.delegate = self
    return listingCell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let viewSize = collectionView.frame.size
    let spacing: CGFloat = 11
    let edgeLength = (viewSize.width / 2) - spacing
    return CGSize(width: edgeLength, height: edgeLength)
  }
}

extension ListingViewController: CustomPickerDelegate {
  func selectedValueInPicker(picker: CustomPicker, index: Int, value: String) {
    listingPresenter?.getListOfMovie(option: sortOptions[index].value)
  }
  
  func canceledSelection(picker: CustomPicker) {
  }
}

extension ListingViewController: ListingCollectionViewCellDelegate {
  func listingCollectionViewCell(_ cell: ListingCollectionViewCell, didTapDislikeButton button: UIButton) {
    guard let rowTapped = collectionView.indexPath(for: cell)?.row else {
      return
    }
    let dislikedMovie = movies[rowTapped]
    removeDislikedMovieFromDisplayList(movie: dislikedMovie)
  }
}
