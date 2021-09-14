//
//  MovieDetails.swift
//  Burner iOS App
//
//  Created by Ayush Singh on 13/09/21.
//

import Foundation
// Api
let imdbID = "tt3896198"
let key = "8f7068fa"

//Movies Data
var moviesTitle = [String]()
var moviesType = [String]()
var moviesPoster = [String]()
var moviesYear = [String]()

//Search Data
var searchData = String()

public class MovieDetails {

    let title:String
    let year:String
    let rated:String
    let released:String
    let runtime:String
    let genre:String
    let director:String
    let writer:String
    let actors:String
    let plot:String
    let language:String
    let country:String
    let awards:String
    let poster:String

    init(title:String, year:String, rated:String, released:String, runtime:String, genre:String, director:String, writer:String, actors:String, plot:String, language:String, country:String, awards:String, poster:String) {
        self.title = title
        self.year = year
        self.rated = rated
        self.released = released
        self.runtime = runtime
        self.genre = genre
        self.director = director
        self.writer = writer
        self.actors = actors
        self.plot = plot
        self.language = language
        self.country = country
        self.awards = awards
        self.poster = poster
    }
    
    
}
