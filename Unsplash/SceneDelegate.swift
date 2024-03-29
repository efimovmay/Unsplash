//
//  SceneDelegate.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

	var window: UIWindow?
	private var appCoordinator: ICoordinator! // swiftlint:disable:this implicitly_unwrapped_optional

	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		
		let tabBarController = TabBarController()
		let networkManager = NetworkManager()
		appCoordinator = AppCoordinator(tabBarController: tabBarController, window: window, networkManager: networkManager)
		appCoordinator.start()
		
		self.window = window
	}
}
