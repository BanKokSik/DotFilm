//
//  FilmModel.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 06.07.2022.
//

import Foundation

struct FilmModel: Codable{
    let moves: [Movie]
    
}

struct Movie: Codable{
    let id: Int
    let movieLength: Int?
    let name: String?
    let description: String?
    let year: Int
    let poster: Poster
    let rating: Rating
}

struct Poster: Codable {
    let url: String
}

struct Rating: Codable {
    let kp: Double
}
