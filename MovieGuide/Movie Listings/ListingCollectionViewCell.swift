//
//  ListingCollectionViewCell.swift
//  MovieGuide
//
//  Created by Saket Gupte on 08/02/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class ListingCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  
  func configure(movie: MovieListViewModel) {
    self.titleLabel.text = movie.title
    if let posterURL = movie.posterURL {
      self.posterImageView.af_setImage(withURL: posterURL)
    }
  }
  
  override func prepareForReuse() {
    self.posterImageView.af_cancelImageRequest()
  }
}
