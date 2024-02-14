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
		randomImagesScene()
	}
	
	private func randomImagesScene() {
		let viewController = RandomImagesAssembler(networkManager: networkManager).assembly { [weak self] image in
			self?.detailScene(image: image)
		}
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
