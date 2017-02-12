//
//  NibLoadableView.swift
//  MovieGuide
//
//  Created by Saket Gupte on 1/17/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadableView: class {
  static var nibName: String {get}
}

extension NibLoadableView where Self: UIView {
  static var nibName: String {
    return NSStringFromClass(self)
  }
}

extension ListingTableViewCell: NibLoadableView {
}

extension ListingCollectionViewCell: NibLoadableView {
}


extension UICollectionView {
  
  func register<T: UICollectionViewCell> (_: T.Type) where T: ReusableView {
    register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
  }
  
  func register<T: UICollectionViewCell> (_: T.Type) where T: ReusableView, T:NibLoadableView {
    let nib = UINib(nibName:T.nibName, bundle: nil)
    
    register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
  }
  
  func dequeueReusableCell<T:UICollectionViewCell>(indexPath: IndexPath) -> T where T:ReusableView {
    
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
    }
    
    return cell
  }
}

extension UITableView {

  func register<T: UITableViewCell> (_: T.Type) where T: ReusableView {
    register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }

  func register<T: UITableViewCell> (_: T.Type) where T: ReusableView, T:NibLoadableView {
    let nib = UINib(nibName:T.nibName, bundle: nil)

    register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }

  func dequeueReusableCell<T:UITableViewCell>(indexPath: IndexPath) -> T where T:ReusableView {

    guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
      fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
    }

    return cell
  }
}
