//
//  DetailPresenter.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 13.02.2024.
//

import Foundation

/// Протокол презентера экрана детальной информации.
protocol IDetailPresenter: AnyObject {
	
	/// Экран готов для отображения информации.
	func viewIsReady()
	
	/// Загрузка изображения.
	/// - Parameter url: строка URL изображения.
	func fetch(url: String, completion: @escaping(Data) -> Void)
	
	/// Добавить в избранное (удалить).
	func addInFavorite()
}

/// Презентер для главного экрана
final class DetailPresenter: IDetailPresenter {
	
	// MARK: - Dependencies
	
	weak var view: IDetailViewController?
	private let networkManager: INetworkManager
	private let coreDataManager: ICoreDataManager
	
	// MARK: - Private properties
	
	private var image: Image?
	
	// MARK: - Initialization
	
	required init(
		view: IDetailViewController,
		networkManager: INetworkManager,
		image: Image,
		coreDataManager: ICoreDataManager
	) {
		self.view = view
		self.networkManager = networkManager
		self.image = image
		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Public methods
	
	func viewIsReady() {
		var isfavorite = false
		if coreDataManager.getImage(url: image?.links.linksSelf ?? "") != nil {
			isfavorite = true
		}
		
		view?.render(viewData: DetailModel.ViewData(
			photo: image?.urls.regular ?? "n/a",
			user: image?.user.name ?? "n/a",
			createdAt: image?.createdAt?.formateDate() ?? "n/a",
			location: image?.location?.name ?? "n/a",
			downloads: String(image?.downloads ?? 0),
			isFaivorite: isfavorite
		))
	}
	
	func fetch(url: String, completion: @escaping(Data) -> Void) {
		networkManager.fetchData(from: url) { result in
			switch result {
			case .success(let data):
				completion(data)
			case .failure(let error):
				print(error.localizedDescription) // swiftlint:disable:this print_using
			}
		}
	}
	
	func addInFavorite() {
		if let image = coreDataManager.getImage(url: image?.links.linksSelf ?? "") {
			coreDataManager.deleteImage(image)
			view?.updateIsFavoriteButton(isFaivorite: false)
		} else {
			coreDataManager.create(
				url: image?.links.linksSelf ?? "",
				author: image?.user.name ?? "",
				linkToImage: image?.urls.small ?? ""
			)
			view?.updateIsFavoriteButton(isFaivorite: true)
		}
	}
}
