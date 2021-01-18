//
//  MovieListTableViewController.swift
//  Movies
//
//  Created by stanley phillips on 1/14/21.
//

import UIKit

class MovieListTableViewController: UITableViewController {

    // MARK: - Lifecyle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieController.shared.loadFromPersistentStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieController.shared.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {return UITableViewCell()}
        
        cell.delegate = self
        cell.updateCellWith(movie: MovieController.shared.movies[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movieToDelete = MovieController.shared.movies[indexPath.row]
            MovieController.shared.delete(movie: movieToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMovieDetailVC" {
            guard let index = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MovieDetailViewController else {return}
            let movieToSend = MovieController.shared.movies[index.row]
            destination.movie = movieToSend
        }
    }
}

// MARK: -  Custom Cell Delegate Methods
extension MovieListTableViewController: MovieTableViewCellDelegate {
    func toggleIsWatched(_ sender: MovieTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let movieToToggle = MovieController.shared.movies[indexPath.row]
        MovieController.shared.toggleIsWatched(movie: movieToToggle)
        self.tableView.reloadData()
    }
}
