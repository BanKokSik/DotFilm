//
//  MovieTableViewCell.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 10.07.2022.
//

import UIKit
import Kingfisher
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    @IBOutlet weak var filmLenght: UILabel!
    @IBOutlet weak var filmRating: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellConfigurate(film: Doc){
        if let name = film.name{
            filmName.text = name
        } else{
            filmName.text = "No data."
        }
        filmYear.text = String(film.year)
        filmLenght.text = String("\(film.movieLength!) мин.")
        filmRating.text = String("Рейтинг: \(film.rating.kp)")
        filmPoster.kf.setImage(with: URL(string: film.poster.url))
    }
}
