//
//  MovieDataViewController.swift
//  Burner iOS App
//
//  Created by Ayush Singh on 13/09/21.
//

import UIKit

class MovieDataViewController: UIViewController {

    
    var segueData:String!
    var imageMovieDetailsUrl:String!
    var nameMovieDetails:String!
    var plotMovieDetails:String!
    var releasedMovieDetails:String!
    var ratedMovieDetails:String!
    var genreMovieDetails:String!
    var countryMovieDetails:String!
    var directorMovieDetails:String!
    var actorsMovieDetails:String!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var delegateMovieDetails : MovieListingViewController?
    
    @IBOutlet weak var movieDetailsImageView: UIImageView!
    @IBOutlet weak var titleMovieDetailsTextView: UILabel!
    @IBOutlet weak var plotMovieDetailsTextView: UILabel!
    @IBOutlet weak var releasedTextView: UILabel!
    @IBOutlet weak var ratedTextView: UILabel!
    @IBOutlet weak var genreTextView: UILabel!
    @IBOutlet weak var countryTextView: UILabel!
    @IBOutlet weak var directorTextView: UILabel!
    @IBOutlet weak var actorsTextView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        loadMovieDetails()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        movieDetailsImageView.layer.masksToBounds = true
        movieDetailsImageView.layer.cornerRadius = 15
    }
    
    public func loadMovieDetails() {
        loadingView.alpha = 1
        showActivityIndicator()
        let movieName = segueData.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        
        let urlApi = "http://www.omdbapi.com/?i=\(imdbID)&apikey=\(key)&t="+movieName
        print(urlApi)
        let url = URL(string: urlApi)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {
                print("error")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                        
                        if let poster = myJson["Poster"] {
                            self.imageMovieDetailsUrl = String(describing: poster)
                        }
                        if let title = myJson["Title"] {
                            self.nameMovieDetails = String(describing: title)
                        }
                        if let plot = myJson["Plot"] {
                            self.plotMovieDetails = String(describing: plot)
                        }
                        if let released = myJson["Released"] {
                            self.releasedMovieDetails = String(describing: released)
                            print(released)
                        }
                        if let rated = myJson["Rated"] {
                            self.ratedMovieDetails = String(describing: rated)
                            print(rated)
                        }
                        if let genre = myJson["Genre"] {
                            self.genreMovieDetails = String(describing: genre)
                            print(genre)
                        }
                        if let country = myJson["Country"] {
                            self.countryMovieDetails = String(describing: country)
                            print(country)
                        }
                        if let director = myJson["Director"] {
                            self.directorMovieDetails = String(describing: director)
                        }
                        if let actors = myJson["Actors"] {
                            self.actorsMovieDetails = String(describing: actors)
                        }

                        let imageUrl = self.imageMovieDetailsUrl
                        let url = URL(string: imageUrl!)
                        let data = try? Data(contentsOf: url!)
                        DispatchQueue.main.async {
                            if let imageData = data {
                                let image = UIImage(data: imageData)
                                self.movieDetailsImageView.image = image
                            }else{
                                self.movieDetailsImageView.image = UIImage(named: "image-nil")
                            }
                            
                            self.titleMovieDetailsTextView.text = self.nameMovieDetails
                            self.plotMovieDetailsTextView.text = self.plotMovieDetails
                            self.releasedTextView.text = self.releasedMovieDetails
                            self.ratedTextView.text = self.ratedMovieDetails
                            self.genreTextView.text = self.genreMovieDetails
                            self.countryTextView.text = self.countryMovieDetails
                            self.directorTextView.text = self.directorMovieDetails
                            self.actorsTextView.text = self.actorsMovieDetails
                            self.loadingView.alpha = 0
                            self.stopActivityIndicator()
                        }

                    }
                    catch
                    {
                        print("error in JSONSerialization")
                    }
                }
            }
        }
        task.resume()

    }
    func showActivityIndicator() {
        activityIndicator.alpha = 1
        activityIndicator.startAnimating()
        
    }
    func stopActivityIndicator() {
        activityIndicator.alpha = 0
        activityIndicator.stopAnimating()
    }
    


}
