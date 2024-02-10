//
//  AppCoordinator.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
	
	// MARK: - Dependencies
	
	private let navigationController: UINavigationController
	private var window: UIWindow?
	
	// MARK: - Initialization
	
	init(window: UIWindow?) {
		self.window = window
		self.navigationController = UINavigationController()
	}
	
	// MARK: - Internal methods
	
	override func start() {
		runMainFlow()
	}
	
	func runMainFlow() {
		let tabBarController = TabBarController()
		let coordinator = MainCoordinator(tabBarController: tabBarController)
		addDependency(coordinator)
		coordinator.start()
		
		navigationController.isNavigationBarHidden = true
		navigationController.setViewControllers([tabBarController], animated: true)
		
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
	}
}
