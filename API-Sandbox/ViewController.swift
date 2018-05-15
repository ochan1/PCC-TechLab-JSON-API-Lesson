//
//  ViewController.swift
//  API-Sandbox
//
//  Created by Dion Larson on 6/24/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator

class ViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var rightsOwnerLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var randomMovie: Movie!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startExcercises()
        
        let apiToContact = "https://itunes.apple.com/us/rss/topmovies/limit=25/json"
        // This code will call the iTunes top 25 movies endpoint listed above
        Alamofire.request(apiToContact).validate().responseJSON() { response in
            //Alamofire connects to internet. Similar to GET request
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    // Do what you need to with JSON here!
                    let allMoviesJSON = json["feed"]["entry"].arrayValue
                    
                    /*
                    var allMovies = [Movie]()
                    
                    for movieJSON in allMoviesJSON {
                        let movie = Movie(json: movieJSON)
                        allMovies.append(movie)
                    }
                    */
                    
                    let allMovies = allMoviesJSON.map { Movie(json: $0) }
                    
                    let randomIndex: Int = Int(arc4random_uniform(UInt32(allMovies.count)))
                    self.randomMovie = allMovies[randomIndex]
                    
                    self.movieTitleLabel.text = self.randomMovie.name
                    self.rightsOwnerLabel.text = self.randomMovie.rightsOwner
                    self.releaseDateLabel.text = self.randomMovie.releaseDate
                    self.priceLabel.text = "$\(self.randomMovie.price)"
                    self.loadPoster(urlString: self.randomMovie.posterImageName)
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Updates the image view when passed a url string
    func loadPoster(urlString: String) {
        posterImageView.af_setImage(withURL: URL(string: urlString)!)
    }
    
    @IBAction func viewOniTunesPressed(_ sender: AnyObject) {
        if let link = URL(string: randomMovie.link) {
            UIApplication.shared.openURL(link)
        }
    }
    
    func startExcercises() {
        print("Excercise 1")
        print("-----------------------")
        
        exerciseOne()
        
        print("")
        print("Excercise 2")
        print("-----------------------")
        
        exerciseTwo()
        
        print("")
        print("Excercise 3")
        print("-----------------------")
        
        exerciseThree()
        
        print("-----------------------")
        print("End Exercises")
        print("-----------------------")
    }
    
}

