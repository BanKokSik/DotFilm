//
//  LoadData.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 10.07.2022.
//

import Foundation
import Alamofire


class LoadData {
   static let load = LoadData()
    
    func fetchMovies(complition: @escaping ([Movie]) -> Void) {
        AF.request("https://api.kinopoisk.dev/movie?field=rating.kp&search=5-10&field=year&search=2015-2020&field=typeNumber&search=1&sortField=votes.imdb&sortType=-1&limit=20&page=2&token=XSVFQ1H-BFZM73K-GNVXEQS-XDP320B").responseDecodable(of: FilmModel.self){ response in
            if let filmList = try? response.result.get(){
                complition(filmList.moves)
            }
        }
    }
    
   
    
}
