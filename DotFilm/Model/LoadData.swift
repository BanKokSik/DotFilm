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
    
    func fetchMovies(url: String, parameters: [String:String], complition: @escaping (FilmModel) -> Void) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.asyncAfter(deadline: .now() + 10.0) {
            AF.request(url, parameters: parameters).responseDecodable(of: FilmModel.self){ response in
                if let filmList = try? response.result.get(){
                    DispatchQueue.main.async {
                        complition(filmList)
                    }
                }
            }
        }
      
    }
    
   
    
}
