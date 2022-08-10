//
//  ViewController.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 04.07.2022.
//

import UIKit
import Alamofire
import Kingfisher
import CoreData



class ViewController: UIViewController {
   
    var detailMovie: Doc?
    var person: DetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailData()
        setData(film: detailMovie!)
    }

    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailFilName: UILabel!
    @IBOutlet weak var detailFilmDate: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    
    func setData (film: Doc){
        detailImage.kf.setImage(with: URL(string: film.poster.url))
        detailRating.text = String("Rating: \(film.rating.kp)")
        detailFilName.text = detailMovie?.name
        detailFilmDate.text = String(film.year)
        detailDescription.text = detailMovie?.description
        
    }
    
    @IBAction func likeButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let favoritFilms = FavoriteFilm(context: context)
        favoritFilms.name = detailMovie?.name
        favoritFilms.year = detailMovie?.year
        favoritFilms.descriptions = detailMovie?.description
        favoritFilms.filmId = UUID().uuidString
        
        if let uniqueId = favoritFilms.filmId{
            printContent("Film ID - \(uniqueId)")
        }
    }
    
    
    
    

    
    
    
    func fetchDetailData(){
        AF.request("https://api.kinopoisk.dev/movie?field=id&search=\(detailMovie!.id)&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B").responseDecodable(of: DetailModel.self){ [self]
            response in
            if let detailInfo = try? response.result.get(){
                person = detailInfo
                print(person?.persons.first?.name)
            }
        }
    }

}

