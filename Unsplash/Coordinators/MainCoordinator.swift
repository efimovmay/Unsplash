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
	
	// MARK: - Private properties
	
	private let pages: [TabbarPage] = TabbarPage.allTabbarPages
	
	// MARK: - Initialization
	
	init(tabBarController: UITabBarController) {
		self.tabBarController = tabBarController
	}
	
	// MARK: - Internal methods
	
	override func start() {
		tabBarController.viewControllers?.enumerated().forEach { item in
			guard let controller = item.element as? UINavigationController else { return }
			runFlowByIndex(item.offset, on: controller)
		}
	}
}

// MARK: - run Flows -
private extension MainCoordinator {
	func runFlowByIndex(_ index: Int, on controller: UINavigationController) {
		let coordinator: ICoordinator
		switch pages[index] {
		case .randomImages:
			coordinator = FavotiteImagesCoordonator(
				navigationController: controller
			)
		case .favoriteImages:
			coordinator = RandomImagesCoordinator(
				navigationController: controller
			)
		}
		addDependency(coordinator)
		coordinator.start()
	}
}
