//
//  FavoriteFilm+CoreDataProperties.swift
//  DotFilm
//
//  Created by Nikita Chekmarev on 08.08.2022.
//
//

import Foundation
import CoreData


extension FavoriteFilm {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteFilm> {
        return NSFetchRequest<FavoriteFilm>(entityName: "FavoriteFilm")
    }

    @NSManaged public var name: String?
    @NSManaged public var year: Int64
    @NSManaged public var descriptions: String?
    @NSManaged public var filmId: UUID
    

}

extension FavoriteFilm : Identifiable {

}
