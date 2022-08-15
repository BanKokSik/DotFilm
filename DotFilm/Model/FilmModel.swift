//
//  FilmModel.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 06.07.2022.
//

import Foundation

struct FilmModel: Codable{
    let docs: [Doc]
    let pages: Int
    
}

struct Doc: Codable{
    let id: Int
    let movieLength: Int16?
    let name: String?
    let description: String?
    let year: Int16
    let poster: Poster
    let rating: Rating
}

struct Poster: Codable {
    let url: String
}

struct Rating: Codable {
    let kp: Double
}
