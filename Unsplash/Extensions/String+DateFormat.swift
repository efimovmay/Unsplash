//
//  String+DateFormat.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 15.02.2024.
//

import Foundation

extension String {
	func formateDate() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
		
		if let date = dateFormatter.date(from: self) {
			dateFormatter.dateFormat = "d MMM yyyy"
			return dateFormatter.string(from: date)
		}
		return self
	}
}
