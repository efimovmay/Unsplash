//
//  RandomImageCoordinator.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

final class RandomImagesCoordinator: ICoordinator {
	
	// MARK: - Dependencies
	
	private let navigationController: UINavigationController
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}
	
	// MARK: - Internal methods
	
	func start() {
		randomImagesScene()
	}
	
	private func randomImagesScene() {
		let viewController = RandomImagesViewController()
		navigationController.pushViewController(viewController, animated: true)
	}
}
