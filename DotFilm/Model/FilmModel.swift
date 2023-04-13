//
//  FilmModel.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 06.07.2022.
//

import Foundation
import CoreData

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
    
    static func docFrom (dataBaseModel: FavoriteFilm) -> Doc{
        return Doc(id: Int(dataBaseModel.id), movieLength: dataBaseModel.movieLenght, name: dataBaseModel.name, description: dataBaseModel.descriptions, year: dataBaseModel.year, poster: Poster(url: dataBaseModel.poster ?? ""), rating: Rating.init(kp: dataBaseModel.rating))
    }
}

struct Poster: Codable {
    let url: String
}

struct Rating: Codable {
    let kp: Double
}
