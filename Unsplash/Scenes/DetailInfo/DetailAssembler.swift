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
	
	// MARK: - Initialization
	init(networkManager: INetworkManager, image: Image) {
		self.networkManager = networkManager
		self.image = image
	}
	
	// MARK: - Public methods
	func assembly() -> DetailViewController {
		let viewController = DetailViewController()
		let presenter = DetailPresenter(view: viewController, networkManager: networkManager, image: image)
		viewController.presenter = presenter
		
		return viewController
	}
}
