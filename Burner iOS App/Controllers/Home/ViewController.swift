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
        self.stopActivityIndicator()
        movies?.removeAll()
        self.hideKeyboardWhenTappedAround()
    }
    
    func searchMovies() {
        showActivityIndicator()
        searchData = searchBox.text!
        let value = String("http://www.omdbapi.com/?i=\(imdbID)&apikey=\(key)&s=\(searchData)")
        let urlTrimmed:String = value.replacingOccurrences(of: " ", with: "%20")
        let url = URL(string: urlTrimmed)

        print(url!)
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
    func checkNetwork() {
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            searchMovies()
            
        }else{
            print("Internet Connection not Available!")
            self.showToast(message: "Internet Connection not Available!", font: .systemFont(ofSize: 12.0))
            
        }
    
    }
    
    func checkErrors() {
        if !searchBox.text!.trimmingCharacters(in: .whitespaces).isEmpty {
            print(searchBox.text!.trimmingCharacters(in: .whitespaces))
            checkNetwork()
        }else{
            self.showToast(message: "Please enter some value", font: .systemFont(ofSize: 12.0))
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            if movies?.count == 0 {
                print("Not Found")
                self.stopActivityIndicator()
                self.showToast(message: "Result Not Found", font: .systemFont(ofSize: 12.0))
            }else{
                self.checkNetwork()
            }
        }
    }
    

    
    @IBAction func searchBtn(_ sender: Any) {
        
        //Check Network and Search Movies
        checkErrors()
        
    }
    
    
}

extension UIViewController {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 120, y: self.view.frame.size.height-100, width: 250, height: 40))
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.9)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

