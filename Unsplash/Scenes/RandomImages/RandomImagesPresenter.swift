//
//  RandomImagesPresenter.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

/// Протокол презентера для отображения главного экрана.
protocol IRandomImagesPresenter: AnyObject {
	
	/// Экран готов для отображения информации.
	func viewIsReady()
	
	/// Загрузка изображения.
	/// - Parameter index: индекс изображения.
	func fetch(index: Int, completion: @escaping(Data) -> Void)
	
	/// Нажат item коллекции
	func didItemSelected(index: Int)
	
	/// Загрузка изображений по поиску.
	/// - Parameter searchBy: текст для поиска.
	func fetchSearchImage(searchBy: String)
}
 
typealias ImageClosure = (Image) -> Void

final class RandomImagesPresenter: IRandomImagesPresenter {
	
	// MARK: - Dependencies
	
	weak var view: IRandomImagesViewController?
	private var networkManager: INetworkManager
	private var openDetailScene: ImageClosure?
	
	// MARK: - Private properties
	
	private var images: [Image] = []
	
	// MARK: - Initialization
	
	required init(view: IRandomImagesViewController, networkManager: INetworkManager, openDetailScene: ImageClosure?) {
		self.view = view
		self.networkManager = networkManager
		self.openDetailScene = openDetailScene
	}
	
	// MARK: - Public methods
	
	func viewIsReady() {
		networkManager.fetchRandomImages { result in
			switch result {
			case .success(let images):
				self.images = images
				self.view?.renderCollection(viewData: RandomImagesModel.ViewData(images: images))
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func fetchSearchImage(searchBy: String) {
		networkManager.fetchSearchImages(searchBy: searchBy) { result in
			switch result {
			case .success(let images):
				self.images = images
				self.view?.renderCollection(viewData: RandomImagesModel.ViewData(images: images))
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func fetch(index: Int, completion: @escaping(Data) -> Void) {
		let url = images[index].urls.small
		networkManager.fetchData(from: url) { result in
			switch result {
			case .success(let data):
				completion(data)
			case .failure(let error):
				print(error.localizedDescription)
			}
		}
	}
	
	func didItemSelected(index: Int) {
		let image = images[index]
		openDetailScene?(image)
	}
}
