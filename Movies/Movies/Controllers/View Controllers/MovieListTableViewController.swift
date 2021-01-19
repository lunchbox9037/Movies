//
//  MovieListTableViewController.swift
//  Movies
//
//  Created by stanley phillips on 1/14/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {
    // MARK: - Properties
    //create a nested array to hold new arrays containing movies that have been watched and unwatched
    var sectionedMovies: [[Movie]] = []
    //creat an enum to represent the sections
    enum Section: Int {
        case haveNotWatched
        case haveWatched
    }
    
    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSectionedMovies()
    }
    
    // MARK: - Methods
    func updateSectionedMovies() {
        let haveWatched: [Movie] = MovieController.shared.movies.filter {$0.isWatched}
        let haveNotWatched: [Movie] = MovieController.shared.movies.filter {!$0.isWatched}
        sectionedMovies = []
        sectionedMovies.append(haveNotWatched)
        sectionedMovies.append(haveWatched)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedMovies.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section) {
        case .haveNotWatched:
            return "Unwatched"
        case .haveWatched:
            return "Watched"
        default:
            return "Other"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedMovies[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        cell.delegate = self
        cell.updateCellWith(movie: sectionedMovies[indexPath.section][indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movieToDelete = sectionedMovies[indexPath.section][indexPath.row]
            MovieController.shared.delete(movie: movieToDelete)
            //deletes the movie from the sectioned array as well to prevent loading the wrong data a crashing the app
            sectionedMovies[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            updateSectionedMovies()
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MovieDetailViewController else {return}
            let movieToSend = sectionedMovies[indexPath.section][indexPath.row]
            destination.movie = movieToSend
        }
    }
}//end of class

// MARK: -  Custom Cell Delegate Methods
extension MovieListTableViewController: MovieTableViewCellDelegate {
    func toggleIsWatched(_ sender: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let movieToToggle = sectionedMovies[indexPath.section][indexPath.row]
        MovieController.shared.toggleIsWatched(movie: movieToToggle)
        updateSectionedMovies()
    }
}
