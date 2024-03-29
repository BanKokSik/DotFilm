//
//  MovieTableViewCell.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 10.07.2022.
//

import UIKit
import Kingfisher


class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    @IBOutlet weak var filmLenght: UILabel!
    @IBOutlet weak var filmRating: UILabel!

    
 
    
    func cellConfigurate(film: Doc){
        if let name = film.name{
            filmName.text = name
        } else{
            filmName.text = "No data."
        }
        filmYear.text = String(film.year)
        if let lengtht = film.movieLength{
            filmLenght.text = String("\(lengtht) мин.")
        } else{
            filmLenght.text = "!!!!!!NO DATA!!!!!!!"
        }
        
        filmRating.text = String("Рейтинг: \(film.rating.kp)")
        filmPoster.kf.setImage(with: URL(string: film.poster.url))
    }
}
