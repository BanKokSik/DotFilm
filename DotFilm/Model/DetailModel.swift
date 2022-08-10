//
//  DetailModel.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 27.07.2022.
//

import Foundation

struct DetailModel: Codable{
    
    let persons: [Persons]
    
    
}
struct Persons: Codable{
    let name: String
    let description: String?
    let enProfession: String
}
