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

protocol ListingCollectionViewCellDelegate: class {
  func listingCollectionViewCell(_ cell: ListingCollectionViewCell, didTapDislikeButton button: UIButton)
}

class ListingCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var dislikeButton: UIButton!
  weak var delegate: ListingCollectionViewCellDelegate?
  
  func configure(movie: ListViewModel) {
    self.titleLabel.text = movie.title
    if let posterURL = movie.posterURL {
      self.posterImageView.af_setImage(withURL: posterURL)
    }
  }
  
  override func prepareForReuse() {
    self.posterImageView.af_cancelImageRequest()
  }
  
  
  @IBAction func dislikeButtonTapped(_ sender: UIButton) {
    guard let delegate = delegate else {
      return
    }
    
    delegate.listingCollectionViewCell(self, didTapDislikeButton: sender)
  }
}
