//
//  AppCoordinator.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
	
	// MARK: - Dependencies
	
	private var window: UIWindow?
	
	// MARK: - Initialization
	
	init(window: UIWindow?) {
		self.window = window
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
		
		window?.rootViewController = tabBarController
		window?.makeKeyAndVisible()
	}
}
