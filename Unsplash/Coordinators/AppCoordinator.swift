//
//  AppCoordinator.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
	
	// MARK: - Dependencies
	
	private let tabBarController: UITabBarController
	private let window: UIWindow?
	private let networkManager: INetworkManager
	
	// MARK: - Initialization
	init(tabBarController: UITabBarController, window: UIWindow?, networkManager: INetworkManager) {
		self.tabBarController = tabBarController
		
		self.window = window
		self.window?.rootViewController = tabBarController
		self.window?.makeKeyAndVisible()
		
		self.networkManager = networkManager
	}
	
	// MARK: - Internal methods
	override func start() {
		runMainFlow()
	}
	
	func runMainFlow() {
		let coordinator = MainCoordinator(tabBarController: tabBarController, networkManager: networkManager)
		addDependency(coordinator)
		coordinator.start()
	}
}
