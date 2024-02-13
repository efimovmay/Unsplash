//
//  RandomImagesAssembler.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

final class RandomImagesAssembler {
	
	// MARK: - Dependencies
	private let networkManager: INetworkManager
	
	// MARK: - Initialization
	init(networkManager: INetworkManager) {
		self.networkManager = networkManager
	}
	
	// MARK: - Public methods
	func assembly(openDetailScene: ImageClosure?) -> RandomImagesViewController {
		let viewController = RandomImagesViewController()
		let presenter = RandomImagesPresenter(
			view: viewController,
			networkManager: networkManager,
			openDetailScene: openDetailScene
		)
		viewController.presenter = presenter
		
		return viewController
	}
}
