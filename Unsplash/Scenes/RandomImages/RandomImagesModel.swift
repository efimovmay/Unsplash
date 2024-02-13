//
//  RandomImagesModel.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

enum RandomImagesModel {
	/// Структура описывающая главный экран приложения
	struct ViewData {
		let images: [ImageData]
		let count: Int
	}
	
	struct ImageData {
		let data: Data?
	}
}
