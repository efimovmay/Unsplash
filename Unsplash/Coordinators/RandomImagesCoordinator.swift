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
	private let networkManager: INetworkManager
	
	// MARK: - Initialization
	
	init(navigationController: UINavigationController, networkManager: INetworkManager) {
		self.navigationController = navigationController
		self.networkManager = networkManager
	}
	
	// MARK: - Internal methods
	
	func start() {
		randomImagesScene()
	}
	
	private func randomImagesScene() {
		let viewController = RandomImagesAssembler(networkManager: networkManager).assembly()
		navigationController.pushViewController(viewController, animated: true)
	}
}
