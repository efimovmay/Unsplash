//
//  DetailModel.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 13.02.2024.
//

import Foundation

enum DetailModel {
	/// Структура описывающая главный экран приложения
	struct ViewData {
		let photo: String
		let user: String
		let createdAt: String
		let location: String
		let downloads: String
		let isLike: Bool
	}
}
