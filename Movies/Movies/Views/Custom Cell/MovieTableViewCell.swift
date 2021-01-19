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
    @IBOutlet weak var cellView: UIView!
    
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
        if movie.isWatched {
            cellView.backgroundColor = UIColor.systemFill
            titleLabel.textColor = UIColor.systemFill
            whereToWatchLabel.textColor = UIColor.systemFill
        } else {
            cellView.backgroundColor = UIColor.systemGroupedBackground
            titleLabel.textColor = UIColor.label
            whereToWatchLabel.textColor = UIColor.systemBlue
        }
        updateWatchedStatus(isWatched: movie.isWatched)
    }
    
    func updateWatchedStatus(isWatched: Bool) {
        let imageName = isWatched ? "checkmark.square" : "square"
        isWatchedButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
}
