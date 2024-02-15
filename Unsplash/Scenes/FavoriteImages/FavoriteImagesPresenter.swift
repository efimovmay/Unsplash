//
//  FavoriteImagesPresenter.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 14.02.2024.
//

import Foundation

/// Протокол презентера для отображения экрана избранных изображений
protocol IFavoriteImagesPresenter: AnyObject {
	
	/// Экран готов для отображения информации.
	func viewIsReady()
	
	/// Загрузка изображения.
	/// - Parameter index: индекс изображения.
	func fetch(index: Int, completion: @escaping(Data) -> Void)
	
	/// Нажат item коллекции
	func didItemSelected(index: Int)
	
	/// Удаляет из избранного
	func deleteImage(index: Int)
}

typealias ImageClosureFavorite = (Image) -> Void

final class FavoriteImagesPresenter: IFavoriteImagesPresenter {
	
	// MARK: - Dependencies
	
	weak var view: IFavoriteImagesViewController?
	private var networkManager: INetworkManager
	private let coreDataManager: ICoreDataManager
	private var openDetailScene: ImageClosureFavorite?
	
	// MARK: - Private properties
	
	private var images: [FavoriteImage] = []
	
	// MARK: - Initialization
	
	required init(
		view: IFavoriteImagesViewController,
		networkManager: INetworkManager,
		openDetailScene: ImageClosureFavorite?,
		coreDataManager: ICoreDataManager
	) {
		self.view = view
		self.networkManager = networkManager
		self.openDetailScene = openDetailScene
		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Public methods
	
	func viewIsReady() {
		coreDataManager.fetchData { [unowned self] result in
			switch result {
			case .success(let images):
				self.images = images
				var favoriteImages: [FavoriteImagesModel.FavImage] = []
				for image in images {
					favoriteImages.append(
						FavoriteImagesModel.FavImage(
							imageUrl: image.linkToImage ?? "",
							author: image.author ?? ""
						)
					)
				}
				view?.render(viewData: FavoriteImagesModel.ViewData(images: favoriteImages))
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func fetch(index: Int, completion: @escaping(Data) -> Void) {
		guard let url = images[index].linkToImage else { return }
		networkManager.fetchData(from: url) { result in
			switch result {
			case .success(let data):
				completion(data)
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func didItemSelected(index: Int) {
		guard let url = images[index].url else { return }
		networkManager.fetchImage(link: url) { result in
			switch result {
			case .success(let image):
				self.openDetailScene?(image)
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func deleteImage(index: Int) {
		let image = images[index]
		coreDataManager.deleteImage(image)
	}
}
