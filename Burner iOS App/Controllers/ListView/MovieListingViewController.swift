//
//  MovieListingViewController.swift
//  Burner iOS App
//
//  Created by Ayush Singh on 13/09/21.
//

import UIKit

class MovieListingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var queryLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryLbl.text = "Search result of “\(searchData)”"
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

   
    }
    //Data Passing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "movieDetail") {
            let view = segue.destination as! MovieDataViewController
            movie = movies?[tableView.indexPathForSelectedRow!.row]
            view.segueData = movie?.name
            view.delegateMovieDetails = self
        }
    }


}
extension MovieListingViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Set the spacing between sections
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          return 0
      }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return movies!.count
            
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let row = indexPath.row

            
            cell.cellView.backgroundColor = #colorLiteral(red: 0.999244988, green: 0.9686891437, blue: 0.9685176015, alpha: 1)
            cell.cellView.layer.cornerRadius = 10
            cell.nameMovieText.text = movies?[row].name
            cell.typeMovieText.text = movies?[row].type
            cell.yearMovieText.text = movies?[row].year
            
            cell.imageMovieText.layer.masksToBounds = true
            cell.imageMovieText.layer.cornerRadius = 10
            let imageUrl  = movies?[row].poster
            let url = URL(string: imageUrl!)
            let data = try? Data(contentsOf: url!)
            if  let imageData = data {
                let image = UIImage(data: imageData)
                cell.imageMovieText.image = image
            }else{
                cell.imageMovieText.image = UIImage(named: "image-nil")
            }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "movieDetail", sender: self)
    }
    
}
