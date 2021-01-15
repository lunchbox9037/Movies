//
//  Movie.swift
//  Movies
//
//  Created by stanley phillips on 1/14/21.
//

import Foundation

class Movie: Codable {
    var title: String
    var director: String
    var genre: String
    var releaseDate: String
    var watchDate: Date?
    var isWatched: Bool
    
    init(title: String, director: String, genre: String, releaseDate: String, watchDate: Date?, isWatched: Bool = false) {
        self.title = title
        self.director = director
        self.genre = genre
        self.releaseDate = releaseDate
        self.watchDate = watchDate
        self.isWatched = isWatched
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title && lhs.director == rhs.director && lhs.releaseDate == rhs.releaseDate
    }
}
