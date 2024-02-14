//
//  DetailAccembler.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 13.02.2024.
//

import Foundation

final class DetailAssembler {
	
	// MARK: - Dependencies
	private let networkManager: INetworkManager
	private let image: Image
	private let coreDataManager: ICoreDataManager
	
	// MARK: - Initialization
	init(networkManager: INetworkManager, image: Image, coreDataManager: ICoreDataManager) {
		self.networkManager = networkManager
		self.image = image
		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Public methods
	func assembly() -> DetailViewController {
		let viewController = DetailViewController()
		let presenter = DetailPresenter(
			view: viewController,
			networkManager: networkManager,
			image: image,
			coreDataManager: coreDataManager
		)
		viewController.presenter = presenter
		
		return viewController
	}
}
