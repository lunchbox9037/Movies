//
//  MovieController.swift
//  Movies
//
//  Created by stanley phillips on 1/14/21.
//

import Foundation

class MovieController {
    //shared instance
    static var shared = MovieController()
    
    //sot
    var movies: [Movie] = []
    
    // MARK: - CRUD
    func createMovieWith(title: String, genre: String?, director: String?, whereToWatch: String) {
        let newMovie  = Movie(title: title, genre: genre, director: director, whereToWatch: whereToWatch)
        movies.append(newMovie)
        saveToPersistentStorage()
    }
    
    func update(movie: Movie, title: String, genre: String?, director: String?, whereToWatch: String) {
        movie.title = title
        movie.genre = genre
        movie.director = director
        movie.whereToWatch = whereToWatch
        saveToPersistentStorage()
    }
    
    func toggleIsWatched(movie: Movie) {
        movie.isWatched.toggle()
        saveToPersistentStorage()
    }
    
    func delete(movie: Movie) {
        guard let index = movies.firstIndex(of: movie) else {return}
        movies.remove(at: index)
        saveToPersistentStorage()
    }
    
    // MARK: - Persistence
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Movies.json")
        return documentsDirectoryURL
    }
    
    func saveToPersistentStorage() {
        do {
            //decode and assign the entries array to the a data variable
            let data = try JSONEncoder().encode(movies)
            //write the data to a the file url that was created
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: fileURL())
            movies = try JSONDecoder().decode([Movie].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}
