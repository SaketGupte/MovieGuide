// Generated using Sourcery 0.5.9 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// MARK: DislikedMovies Equatable
extension DislikedMovies: Equatable {
static func ==(lhs: DislikedMovies, rhs: DislikedMovies) -> Bool {
guard lhs.movieId == rhs.movieId else { return false }
return true
}
}
