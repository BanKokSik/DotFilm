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
    var likeButtonTaped = false
    var favoritFilm: [FavoriteFilm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetailData()
        setData(film: detailMovie!)
        doLike()
    }

    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailFilName: UILabel!
    @IBOutlet weak var detailFilmDate: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    @IBOutlet weak var likeButtonColor: UIButton!
    
    func setData (film: Doc){
        detailImage.kf.setImage(with: URL(string: film.poster.url))
        detailRating.text = String("Rating: \(film.rating.kp)")
        detailFilName.text = detailMovie?.name
        detailFilmDate.text = String(film.year)
        detailDescription.text = detailMovie?.description
        
    }
    
    
    @IBAction func likeButton(_ sender: Any) {
        likeButtonTaped = !likeButtonTaped
        if likeButtonTaped{
            saveFilm()
            likeButtonColor.tintColor = .red
        }else{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = FavoriteFilm.fetchRequest() as NSFetchRequest<FavoriteFilm>
            
            do{
                favoritFilm = try context.fetch(fetchRequest)
                for i in favoritFilm{
                    if i.id == detailMovie!.id{
                        context.delete(i)
                    }
                }
            }catch let error {
                print("Could not fetch because of error: \(error).")
        }
            appDelegate.saveContext()
             
            likeButtonColor.tintColor = .blue
            
            }
            
        }
  
    
func saveFilm() {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
        
    let favoritFilms = FavoriteFilm(context: context)
    if let detailMovie = self.detailMovie{
        
            favoritFilms.name =  detailMovie.name
            favoritFilms.year = detailMovie.year
            favoritFilms.descriptions = detailMovie.description
            favoritFilms.rating = detailMovie.rating.kp
            favoritFilms.poster = detailMovie.poster.url
            favoritFilms.movieLenght = detailMovie.movieLength!
            favoritFilms.id = Int32(detailMovie.id)
       
        appDelegate.saveContext()
        }
    }
    func doLike(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = FavoriteFilm.fetchRequest() as NSFetchRequest<FavoriteFilm>
        
        do{
            favoritFilm = try context.fetch(fetchRequest)
            for i in favoritFilm{
                if i.id == detailMovie!.id{
                    likeButtonColor.tintColor = .red
                    likeButtonTaped = true
                }
            }
        }catch let error {
            print("Could not fetch because of error: \(error).")
    
        }
        
    }
    
    

    
    
    
    func fetchDetailData(){
        AF.request("https://api.kinopoisk.dev/movie?field=id&search=\(detailMovie?.id)&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B").responseDecodable(of: DetailModel.self){ [self]
            response in
            if let detailInfo = try? response.result.get(){
                person = detailInfo
                print(person?.persons.first?.name)
            }
        }
    }


}
