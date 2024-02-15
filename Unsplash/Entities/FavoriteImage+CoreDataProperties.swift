//
//  FavoriteImage+CoreDataProperties.swift
//  
//
//  Created by Aleksey Efimov on 14.02.2024.
//
//

import Foundation
import CoreData

extension FavoriteImage {

	/// Сохранение избранных изображений
    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteImage> {
        return NSFetchRequest<FavoriteImage>(entityName: "FavoriteImage")
    }
	/// URL на json
    @NSManaged public var url: String?
	/// Автор
    @NSManaged public var author: String?
	/// Ссылка на изображение
    @NSManaged public var linkToImage: String?
}
