//
//  FavotiteImagesCoordonator.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

final class FavotiteImagesCoordonator: ICoordinator {
	
	// MARK: - Dependencies
	
	private let navigationController: UINavigationController
	private let networkManager: INetworkManager
	private let coreDataManager: ICoreDataManager
	
	// MARK: - Initialization
	
	init(
		navigationController: UINavigationController,
		networkManager: INetworkManager,
		coreDataManager: ICoreDataManager
	) {
		self.navigationController = navigationController
		self.networkManager = networkManager
		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Internal methods
	
	func start() {
		favoriteImagesScene()
	}
	
	private func favoriteImagesScene() {
		let viewController = FavoriteImageViewController()
		navigationController.pushViewController(viewController, animated: true)
	}
	
	private func detailScene(image: Image) {
		let viewController = DetailAssembler(
			networkManager: networkManager,
			image: image,
			coreDataManager: coreDataManager
		).assembly()
		navigationController.pushViewController(viewController, animated: true)
	}
}
