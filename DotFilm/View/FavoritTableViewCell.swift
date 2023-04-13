//
//  FavoritTableViewCell.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 12.08.2022.
//

import UIKit
import Kingfisher

class FavoritTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var favoritFilmPoster: UIImageView!
    @IBOutlet weak var favoritFilmName: UILabel!
    @IBOutlet weak var favoritFilmYear: UILabel!
    @IBOutlet weak var favoritFilmLenght: UILabel!
    @IBOutlet weak var favoritFilmRating: UILabel!
    
    
    
    
    func favoritCellConfigurate(film: FavoriteFilm){
        if let name = film.name{
            favoritFilmName.text = name
        } else{
            favoritFilmName.text = "No data."
        }
        favoritFilmYear.text = String(film.year)
        favoritFilmLenght.text = String("\(film.movieLenght) мин.")
        favoritFilmRating.text = String("Рейтинг: \(film.rating)")
        favoritFilmPoster.kf.setImage(with: URL(string: film.poster!))
    }
    
}
