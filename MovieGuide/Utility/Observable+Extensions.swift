//
//  Observable+Extensions.swift
//  MovieGuide
//
//  Copied from Eidolon on 20/04/17.

import Foundation
import RxSwift

extension Collection where Iterator.Element: ObservableType, Iterator.Element.E: BooleanType {
  func combineLatestOr() -> Observable<Bool> {
    return Observable.combineLatest(self) { bools in
      bools.reduce(false, { (memo, element) in
        return memo || element.boolValue
      })
    }
  }
}

extension Observable where Element: Equatable {
  func ignore(value: Element) -> Observable<Element> {
    return filter { (e) -> Bool in
      return value != e
    }
  }
}

protocol BooleanType {
  var boolValue: Bool { get }
}
extension Bool: BooleanType {
  var boolValue: Bool { return self }
}
