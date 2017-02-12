//
//  File.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/17/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
  static var defaultReuseIdentifier: String{get}
}

extension ReusableView where Self: UIView {

  static var defaultReuseIdentifier: String {
      return NSStringFromClass(self)
  }
}

extension UITableViewCell: ReusableView {
}

extension UICollectionViewCell: ReusableView {
}
