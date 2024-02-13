//
//  DetailPresenter.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 13.02.2024.
//

import Foundation

/// Протокол презентера для отображения главного экрана.
protocol IDetailPresenter: AnyObject {
	
	/// Экран готов для отображения информации.
	func viewIsReady()
	func fetch(index: Int, completion: @escaping(Data) -> Void)
}

/// Презентер для главного экрана
final class DetailPresenter: IDetailPresenter {
	
	// MARK: - Dependencies
	weak var view: IDetailViewController?
	var networkManager: INetworkManager
	
	// MARK: - Private properties
	private var image: Image?
	
	// MARK: - Initialization
	required init(view: IDetailViewController, networkManager: INetworkManager, image: Image) {
		self.view = view
		self.networkManager = networkManager
		self.image = image
	}
	
	// MARK: - Public methods
	func viewIsReady() {
	}
	
	func fetch(index: Int, completion: @escaping(Data) -> Void) {
	}
}
