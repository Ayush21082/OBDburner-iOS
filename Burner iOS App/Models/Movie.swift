//
//  Movie.swift
//  Burner iOS App
//
//  Created by Ayush Singh on 13/09/21.

import Foundation


class Movie {
    
    let name:String
    let type:String
    let year:String
    let poster:String
    
    init(name:String, type:String, year:String, poster:String) {
        self.name = name
        self.type = type
        self.year = year
        self.poster = poster
    }
    
}
