//
//  ListingTableViewCell.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/16/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var yearOfReleaseLabel: UILabel!
  @IBOutlet weak var moviePosterImageView: UIImageView!

  func configure(movie: MovieListViewModel) {
    self.titleLabel.text = movie.title
  }

}
