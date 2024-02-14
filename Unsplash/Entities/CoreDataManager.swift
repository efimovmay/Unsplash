//
//  CoreDataManager.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 14.02.2024.
//

import Foundation
import CoreData

protocol ICoreDataManager {
	func create(url: String, author: String, linkToImage: String)
	func deleteImage(_ image: FavoriteImage)
	func fetchData(completion: (Result<[FavoriteImage], Error>) -> Void)
	func saveContext()
}

final class CoreDataManager: ICoreDataManager {
	// MARK: - Core Data stack
	private let persistentContainer: NSPersistentContainer = {
		let container = NSPersistentContainer(name: "FavoriteImages")
		container.loadPersistentStores { _, error in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		}
		return container
	}()
	
	private let viewContext: NSManagedObjectContext
	
	init() {
		viewContext = persistentContainer.viewContext
		}
	
	// MARK: - CRUD
	func create(url: String, author: String, linkToImage: String) {
		let image = FavoriteImage(context: viewContext)
		image.url = url
		image.author = author
		image.linkToImage = linkToImage
		saveContext()
	}
	
	func fetchData(completion: (Result<[FavoriteImage], Error>) -> Void) {
		let fetchRequest = FavoriteImage.fetchRequest()
		
		do {
			let result = try viewContext.fetch(fetchRequest)
			completion(.success(result))
		} catch let error { // swiftlint:disable:this untyped_error_in_catch
			completion(.failure(error))
		}
	}
	
	func deleteImage(_ image: FavoriteImage) {
		viewContext.delete(image)
		saveContext()
	}
	
	// MARK: - Core Data Saving support
	func saveContext() {
		if viewContext.hasChanges {
			do {
				try viewContext.save()
			} catch {
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
}
