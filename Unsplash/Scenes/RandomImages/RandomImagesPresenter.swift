//
//  RandomImagesPresenter.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

/// Протокол презентера для отображения главного экрана.
protocol IRandomImagesPresenter: AnyObject {
	
	/// Загрузка случайных изображений
	func fetchRandom()
	
	/// Нажат item коллекции
	func didItemSelected(index: Int)
	
	/// Загрузка изображений по поиску
	/// - Parameter searchBy: текст для поиска
	func fetchSearchImage(searchBy: String, page: Int)
	
	func fetchNextPage()
}
 
typealias ImageClosure = (Image) -> Void

final class RandomImagesPresenter: IRandomImagesPresenter {
	
	// MARK: - Dependencies
	
	weak var view: IRandomImagesViewController?
	private var networkManager: INetworkManager
	private var openDetailScene: ImageClosure?
	
	// MARK: - Private properties
	
	private var images: [Image] = []
	private var page: Int = 1
	private var searchText: String = ""
	
	// MARK: - Initialization
	
	required init(view: IRandomImagesViewController, networkManager: INetworkManager, openDetailScene: ImageClosure?) {
		self.view = view
		self.networkManager = networkManager
		self.openDetailScene = openDetailScene
	}
	
	// MARK: - Public methods
	
	func fetchRandom() {
		if page != 1 {
			page = 1
			images = []
		}
		networkManager.fetchRandomImages { result in
			switch result {
			case .success(let images):
				self.images.append(contentsOf: images)
				self.view?.renderCollection(viewData: RandomImagesModel.ViewData(images: self.images))
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func fetchSearchImage(searchBy: String, page: Int) {
		if page == 1 {
			searchText = searchBy
			images = []
		}
		networkManager.fetchSearchImages(searchBy: searchBy, page: page) { result in
			switch result {
			case .success(let images):
				self.page += 1
				self.images.append(contentsOf: images)
				self.view?.renderCollection(viewData: RandomImagesModel.ViewData(images: self.images))
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func fetchNextPage() {
		fetchSearchImage(searchBy: searchText, page: page)
	}
	
	func didItemSelected(index: Int) {
		let image = images[index]
		openDetailScene?(image)
	}
}
