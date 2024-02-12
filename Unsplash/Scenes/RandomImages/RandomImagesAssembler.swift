//
//  RandomImagesAssembler.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

final class RandomImagesAssembler {
	
	// MARK: - Dependencies
//	private let coreDataManager: ICoreDataManager
	
	// MARK: - Initialization
	init() {
//		self.coreDataManager = coreDataManager
	}
	
	// MARK: - Public methods
	func assembly() -> RandomImagesViewController {
		let viewController = RandomImagesViewController()
		let presenter = RandomImagesPresenter(view: viewController)
		viewController.presenter = presenter
		
		return viewController
	}
}
