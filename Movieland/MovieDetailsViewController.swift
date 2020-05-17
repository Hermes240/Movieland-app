//
//  MovieDetailsViewController.swift
//  Movieland
//
//  Created by Hermes Obiang on 4/22/20.
//  Copyright © 2020 Hermes Obiang. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    var movie = MovieItem()
    var userRate = 0.0
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var vote: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var yourRating: UILabel!
    @IBOutlet weak var language: UILabel!
    
    
    
    // This function allows the user to rate a movie
    @IBAction func stepper(_ sender: UIStepper)
    {
        sender.maximumValue = 10
        sender.minimumValue = 0
        
        var temp = movie.setUserRating
        temp = (sender.value)
        movie.setUserRating = temp
        yourRating.text = "Your Rating: \(temp)"
        
        var dict2 = UserDefaults.standard.dictionary(forKey: "userRating")
        dict2?.updateValue(movie.setUserRating, forKey: movie.setTitle)
        
        UserDefaults.standard.removeObject(forKey: "userRating")
        UserDefaults.standard.set(dict2, forKey: "userRating")
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        run(after: 1)
        {
            // get the user rating from the dictionary
            let dict2 = UserDefaults.standard.dictionary(forKey: "userRating")
                                 
            let temp = dict2?[self.movie.setTitle] as! Double as Double
            self.userRate = temp
            self.setLabels()
        }
    }
    
    
    //This function initializes all the labels with data from
    // the movie passed to this view
    func setLabels()
    {
        movieImage.image = movie.setImage
        movieName.text = movie.setTitle
        overview.text = "Overview: \n\(movie.setOverview)"
        releaseDate.text = "Release date: \(movie.setDate)"
        movieRating.text = "Rating: \(movie.setRating)"
        vote.text = "Votes: (\(movie.setVote) votes)"
        yourRating.text = "Your Rating: \(userRate)"
        language.text = "Language: \(movie.setLanguage)"
    }
    
    
    
    @IBAction func unwindFromTheater(sender: UIStoryboardSegue)
          {
            // no data to recover from NearbyTheaterViewController
          }
    
    
    // This function pauses an execution for a given amount of seconds
    // it helps me wait for data from threads
    func run(after seconds: Int, completion: @escaping () -> Void)
    {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline)
        {
            completion()
        }
    }
  

}
