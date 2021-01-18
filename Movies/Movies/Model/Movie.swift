//
//  Movie.swift
//  Movies
//
//  Created by stanley phillips on 1/14/21.
//

import Foundation

class Movie: Codable {
    var title: String
    var genre: String
    var director: String?
    var whereToWatch: String?
    var isWatched: Bool
    
    init(title: String, genre: String, director: String?, whereToWatch: String?, isWatched: Bool = false) {
        self.title = title
        self.genre = genre
        self.director = director
        self.whereToWatch = whereToWatch
        self.isWatched = isWatched
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title == rhs.title && lhs.director == rhs.director && lhs.genre == rhs.genre && lhs.whereToWatch == rhs.whereToWatch
    }
}
