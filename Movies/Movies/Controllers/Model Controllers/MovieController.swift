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
    func createMovieWith(title: String, director: String, genre: String, releaseDate: String, watchDate: Date?) {
        let newMovie = Movie(title: title, director: director, genre: genre, releaseDate: releaseDate, watchDate: watchDate)
        movies.append(newMovie)
        //save
        saveToPersistentStorage()
    }
    
    func update(movie: Movie, title: String, director: String, genre: String, releaseDate: String, watchDate: Date?) {
        movie.title = title
        movie.director = director
        movie.genre = genre
        movie.releaseDate = releaseDate
        movie.watchDate = watchDate
        
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
    //create a url
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectoryURL = urls[0].appendingPathComponent("Movies.json")
        return documentsDirectoryURL
    }
    
    //save data
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
    
    //load data
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
