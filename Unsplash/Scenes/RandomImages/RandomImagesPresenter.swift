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
	func fetch(index: Int, completion: @escaping(Data) -> Void)
}

/// Презентер для главного экрана
final class RandomImagesPresenter: IRandomImagesPresenter {
	
	// MARK: - Dependencies
	weak var view: IRandomImagesViewController?
	var networkManager: INetworkManager
	
	// MARK: - Private properties
	private var images: [Image] = []
	
	// MARK: - Initialization
	required init(view: IRandomImagesViewController, networkManager: INetworkManager) {
		self.view = view
		self.networkManager = networkManager
	}
	
	// MARK: - Public methods
	func viewIsReady() {
		networkManager.fetchImages { result in
			switch result {
			case .success(let images):
				self.images = images
				self.view?.renderCollection(viewData: RandomImagesModel.ViewData(images: [], count: images.count))
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
}
