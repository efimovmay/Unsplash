//
//  FavoriteImagesModel.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 14.02.2024.
//

import Foundation

enum FavoriteImagesModel {
	/// Структура описывающая главный экран приложения
	struct ViewData {
		let images: [FavImage]
	}
	struct FavImage {
		let imageUrl: String
		let author: String
	}
}
