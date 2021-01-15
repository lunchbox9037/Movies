//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by stanley phillips on 1/14/21.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var directorLabel: UITextField!
    @IBOutlet weak var genreLabel: UITextField!
    @IBOutlet weak var releaseDateLabel: UITextField!
    @IBOutlet weak var movieWatchedDatePicker: UIDatePicker!
    
    
    // MARK: - Properties
    var movie: Movie?
    var date: Date?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    @IBAction func movieWatchedDatePickerChanged(_ sender: Any) {
        date = movieWatchedDatePicker.date
    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleLabel.text, !title.isEmpty,
              let director = directorLabel.text, !director.isEmpty,
              let genre = genreLabel.text, !genre.isEmpty,
              let releaseDate = releaseDateLabel.text else {return}
        
        if let movie = movie {
            MovieController.shared.update(movie: movie, title: title, director: director, genre: genre, releaseDate: releaseDate, watchDate: date)
        } else {
            MovieController.shared.createMovieWith(title: title, director: director, genre: genre, releaseDate: releaseDate, watchDate: date)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let movieDetails = movie else {return}
        titleLabel.text = movieDetails.title
        directorLabel.text = movieDetails.director
        genreLabel.text = movieDetails.genre
        releaseDateLabel.text = "\(movieDetails.releaseDate)"
        guard let watchedDate = movieDetails.watchDate else {return}
        movieWatchedDatePicker.date = watchedDate
    }
}
