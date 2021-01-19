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
    @IBOutlet weak var whereToWatchPicker: UIPickerView!
    @IBOutlet weak var clearFieldsButton: UIButton!
    
    // MARK: - Properties
    var movie: Movie?
    var whereToWatch: String?
    var whereToWatchValues: [String] = ["Netflix", "Hulu", "Disney+", "Apple TV+", "HBO Max", "Prime Video"]

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        clearFieldsButton.layer.cornerRadius = 8
        //set the view controller as delegate for data and delegate of the uipicker
        whereToWatchPicker.delegate = self
        whereToWatchPicker.dataSource = self
        //default value for the uipicker will always be the first item in the array
        whereToWatch = whereToWatchValues[0]
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleLabel.text, !title.isEmpty,
              let genre = genreLabel.text,
              let director = directorLabel.text,
              let whereToWatch = whereToWatch else {return}
       
        if let movie = movie {
            MovieController.shared.update(movie: movie, title: title, genre: genre, director: director, whereToWatch: whereToWatch)
        } else {
            MovieController.shared.createMovieWith(title: title, genre: genre, director: director, whereToWatch: whereToWatch)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearFieldsButtonTapped(_ sender: Any) {
        titleLabel.text = ""
        directorLabel.text = ""
        genreLabel.text = ""
        whereToWatchPicker.selectRow(0, inComponent: 0, animated: true)
    }
    
    // MARK: - Functions
    func updateViews() {
        guard let movieDetails = movie else {return}
        titleLabel.text = movieDetails.title
        directorLabel.text = movieDetails.director
        genreLabel.text = movieDetails.genre
        let whereToWatchSelected = movieDetails.whereToWatch
        let pickerIndex = whereToWatchValues.firstIndex(of: whereToWatchSelected) ?? 0
        whereToWatchPicker.selectRow(pickerIndex, inComponent: 0, animated: true)
    }
}//end of class

// MARK: - UIPicker DataSource and Delegate methods
extension MovieDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return whereToWatchValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return whereToWatchValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        whereToWatch = whereToWatchValues[row]
    }
}
