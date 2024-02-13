//
//  MainCoordinator.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
	
	// MARK: - Dependencies
	
	private let tabBarController: UITabBarController
	private let networkManager: INetworkManager
	
	// MARK: - Private properties
	
	private let pages: [TabbarPage] = TabbarPage.allTabbarPages
	
	// MARK: - Initialization
	
	init(tabBarController: UITabBarController, networkManager: INetworkManager) {
		self.tabBarController = tabBarController
		self.networkManager = networkManager
	}
	
	// MARK: - Internal methods
	
	override func start() {
		tabBarController.viewControllers?.enumerated().forEach { item in
			guard let controller = item.element as? UINavigationController else { return }
			runFlowByIndex(item.offset, on: controller)
		}
	}
}

// MARK: - run Flows
private extension MainCoordinator {
	func runFlowByIndex(_ index: Int, on controller: UINavigationController) {
		let coordinator: ICoordinator
		switch pages[index] {
		case .randomImages:
			coordinator = RandomImagesCoordinator(navigationController: controller, networkManager: networkManager)
		case .favoriteImages:
			coordinator = FavotiteImagesCoordonator(navigationController: controller)
		}
		addDependency(coordinator)
		coordinator.start()
	}
}
