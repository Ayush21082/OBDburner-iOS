//
//  ViewController.swift
//  Burner iOS App
//
//  Created by Ayush Singh on 13/09/21.
//

import UIKit

var movie:Movie?
var movies:Array<Movie>? = []

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBox: UITextField!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func searchMovies() {
        showActivityIndicator()
        searchData = searchBox.text!
        let url = URL(string: "http://www.omdbapi.com/?i=\(api)&apikey=\(key)&s=\(searchData)")
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
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
                        //JSON search result
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableLeaves) as AnyObject
                        //Adding to multi dimensional array
                        if let search = myJson["Search"] as? [NSDictionary]
                        {
                            for result in search {
                                print(result["Title"]!)
                                print(result["Type"]!)
                                print(result["Poster"]!)
                                print(result["Year"]!)
                                
                                let auxName     = result["Title"]
                                let auxType     = result["Type"]
                                let auxPoster   = result["Poster"]
                                let auxYear     = result["Year"]
                                movies?.append(Movie(name: auxName as! String, type: auxType as! String, year: auxYear as! String, poster: auxPoster as! String))
                            //Adding 1D Array
                                moviesTitle.append(auxName as! String)
                                moviesType.append(auxType as! String)
                                moviesPoster.append(auxPoster as! String)
                                moviesYear.append(auxYear as! String)
                            }
                            DispatchQueue.main.async {
                                self.performSegue(withIdentifier: "movieListing", sender: nil)
                                self.stopActivityIndicator()
                            }
                           
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
    
    

    
    @IBAction func searchBtn(_ sender: Any) {
        searchMovies()
        
    }
    
    
}

