//
//  DetailPresenter.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 13.02.2024.
//

import Foundation

/// Протокол презентера для отображения главного экрана.
protocol IDetailPresenter: AnyObject {
	
	/// Экран готов для отображения информации.
	func viewIsReady()
	func fetch(url: String, completion: @escaping(Data) -> Void)
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
		view?.render(viewData: DetailModel.ViewData(
			photo: image?.urls.regular ?? "n/a",
			user: image?.user.name ?? "n/a",
			createdAt: image?.createdAt ?? "n/a",
			location: image?.location?.name ?? "n/a",
			downloads: String(image?.likes ?? 0),
			isLike: true
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
		coreDataManager.create(
			url: image?.links.linksSelf ?? "",
			author: image?.user.name ?? "",
			linkToImage: image?.urls.small ?? ""
		)
	}
}
