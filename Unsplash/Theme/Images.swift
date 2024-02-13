//
//  Images.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

enum Images {
	enum ImageSF: String {
		case fotos
		case favorite
	}
	
	static func image(kind: ImageSF) -> UIImage {
		let customImage: UIImage
		
		switch kind {
		case .fotos:
			customImage = UIImage(systemName: "photo.fill.on.rectangle.fill") ?? .actions
		case .favorite:
			customImage = UIImage(systemName: "heart.square") ?? .actions
		}
		
		return customImage
	}
}
