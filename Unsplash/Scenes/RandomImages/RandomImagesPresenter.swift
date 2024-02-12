//
//  RandomImagesPresenter.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

/// Протокол презентера для отображения главного экрана.
protocol IRandomImagesPresenter: AnyObject {
	
	/// Экран готов для отображения информации.
	func viewIsReady()
}

/// Презентер для главного экрана
final class RandomImagesPresenter: IRandomImagesPresenter {
	
	// MARK: - Dependencies
	weak var view: IRandomImagesViewController?
	
	// MARK: - Private properties
	private var images: [Image] = []
	
	// MARK: - Initialization
	required init(view: IRandomImagesViewController) {
		self.view = view
	}
	
	// MARK: - Public methods
	func viewIsReady() {
		view?.render(viewData: RandomImagesModel.ViewData(images: images))
	}
}
