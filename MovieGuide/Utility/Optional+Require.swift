//
//  Optional+Require.swift
//  MovieGuide
//
//  Created by Saket Gupte on 18/07/17.
//  Copyright © 2017 Saket Gupte. All rights reserved.
//

import Foundation

extension Optional {

  func require(hint hintExpression: @autoclosure () -> String? , file: StaticString = #file, line: UInt = #line) -> Wrapped {

    guard let unwrapped = self else {
      var message = "Required value was nil in \(file), at line \(line)"

      if let hint = hintExpression() {
        message.append(". Debugging hint: \(hint)")
      }

      preconditionFailure(message)
    }

    return unwrapped
  }

}