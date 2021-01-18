//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by stanley phillips on 1/14/21.
//

import UIKit

protocol MovieTableViewCellDelegate: AnyObject {
    func toggleIsWatched(_ sender: MovieTableViewCell)
}

class MovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var whereToWatchLabel: UILabel!
    @IBOutlet weak var isWatchedButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: MovieTableViewCellDelegate?
    
    // MARK: - Actions
    @IBAction func isWatchedButtonTapped(_ sender: Any) {
        delegate?.toggleIsWatched(self)
    }
    
    
    // MARK: - Methods
    func updateCellWith(movie: Movie) {
        titleLabel.text = movie.title
        whereToWatchLabel.text = movie.whereToWatch
        
        updateWatchedStatus(isWatched: movie.isWatched)
    }
    
    func updateWatchedStatus(isWatched: Bool) {
        let imageName = isWatched ? "checkmark.square" : "square"
        isWatchedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
