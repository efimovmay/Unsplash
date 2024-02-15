//
//  FavoritesImageAssembler.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 14.02.2024.
//

import Foundation

final class FavoriteImagesAssembler {
	
	// MARK: - Dependencies
	
	private let networkManager: INetworkManager
	private let coreDataManager: ICoreDataManager
	
	// MARK: - Initialization
	
	init(networkManager: INetworkManager, coreDataManager: ICoreDataManager) {
		self.networkManager = networkManager
		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Public methods
	
	func assembly(openDetailScene: ImageClosure?) -> FavoriteImagesViewController {
		let viewController = FavoriteImagesViewController()
		let presenter = FavoriteImagesPresenter(
			view: viewController,
			networkManager: networkManager,
			openDetailScene: openDetailScene,
			coreDataManager: coreDataManager
		)
		viewController.presenter = presenter
		
		return viewController
	}
}
