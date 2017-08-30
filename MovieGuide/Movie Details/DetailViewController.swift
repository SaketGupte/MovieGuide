//
//  DetailViewController.swift
//  MovieGuide
//
//  Created by Saket Gupte on 18/07/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var backgroundImageView: UIImageView!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var subtitleLabel: UILabel!
  @IBOutlet weak var ratingImageView: UIImageView!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var votesReceivedLabel: UILabel!

  var movieId: Int

  var presenter: DetailPresenter?

  init(movieId: Int) {
    self.movieId = movieId
    super.init(nibName: nil, bundle: nil)
    configure()
  }

  fileprivate func configure() {
    var presenter: DetailPresenter = DetailPresenterImpl()
    let interactor: DetailInteractor = DetailInteractorImpl(dependencies: DetailDependency())
    let view: DetailView = self

    presenter.view = view
    presenter.interactor = interactor

    self.presenter = presenter
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) is not implemented for ListingViewController")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter?.fetchMovieDetail(forMovieWithId: movieId)
  }

}

fileprivate typealias DetailViewImpl = DetailViewController

extension DetailViewImpl: DetailView {
  func disableDislikeButton() {
  }

  func showMovieDetails(movie: DetailViewModel) {
    self.titleLabel.text = movie.title
    self.setBackgroundImage(withURL: movie.backgroundImageURL)
    self.setSubtitleLabel(ageGroup: movie.ageGroup, runningTime: movie.runningTime, genres: movie.genres)
    self.setRating(rating: movie.rating, votesReceived: movie.votesReceived)
    self.setPosterImage(withURL: movie.posterImageURL)
    self.setOverviewLabel(overview: movie.overview)
  }

  func showErrorView(withErrorMessage errorMessage: String) {
  }
}

fileprivate typealias ViewSetup = DetailViewController

extension ViewSetup {

  fileprivate func setBackgroundImage(withURL url: URL?) {

    guard let url = url else {
      return
    }

    self.backgroundImageView.af_setImage(withURL: url)
  }

  fileprivate func setSubtitleLabel(ageGroup: String?, runningTime: String?, genres: String?) {
    var subtitle: String = ""

    if let ageGroup = ageGroup {
      subtitle += ageGroup + " | "
    }

    if let runningTime = runningTime {
      subtitle += runningTime + " | "
    }

    if let genres = genres {
      subtitle += genres
    }
    self.subtitleLabel.text = subtitle
  }

  fileprivate func setRating(rating: String?, votesReceived: String?) {

    if let rating = rating {
      self.ratingLabel.text = rating
      self.ratingLabel.textColor = UIColor.white
      self.votesReceivedLabel.isHidden = false
    }
    else {
      self.ratingLabel.text = "Not Rated"
      self.ratingLabel.textColor = UIColor.red
      self.votesReceivedLabel.isHidden = true
    }

    if let votesReceived = votesReceived {
      self.votesReceivedLabel.text = votesReceived
    }
  }

  fileprivate func setPosterImage(withURL url: URL?) {

    guard let url = url else {
      return
    }

    self.posterImageView.af_setImage(withURL: url)
  }

  fileprivate func setOverviewLabel(overview: String?) {
    guard let overview = overview else {
      return
    }

    self.overviewLabel.text = overview
  }
}
