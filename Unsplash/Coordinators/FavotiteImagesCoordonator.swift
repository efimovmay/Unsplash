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
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: - Internal methods
	
	func start() {
		favoriteImagesScene()
	}
	
	private func favoriteImagesScene() {
		let viewController = FavoriteImageViewController()
		navigationController.pushViewController(viewController, animated: true)
	}
}
