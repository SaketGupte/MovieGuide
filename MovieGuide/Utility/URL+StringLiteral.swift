//
//  URL+StringLiteral.swift
//  MovieGuide
//
//  Created by Saket Gupte on 18/07/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

extension URL: ExpressibleByStringLiteral {

  public init(stringLiteral value: StaticString) {
    self = URL(string: "\(value)").require(hint: "Invalid URL string literal : \(value)")
  }
}

extension URL {

  public init(extendedGraphemeClusterLiteral value: StaticString) {
    self.init(stringLiteral: value)
  }

  public init(unicodeScalarLiteral value: StaticString) {
    self.init(stringLiteral: value)
  }

}
