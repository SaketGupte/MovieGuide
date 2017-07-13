// Generated using Sourcery 0.5.9 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: DislikedMovie Equatable
extension DislikedMovie: Equatable {
  static func ==(lhs: DislikedMovie, rhs: DislikedMovie) -> Bool {
      guard lhs.movieId == rhs.movieId else {
        return false
      }
    return true
  }
}
