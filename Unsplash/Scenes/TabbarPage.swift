//
//  TabbarPage.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import UIKit

enum TabbarPage {
	case randomImages
	case favoriteImages
	
	func pageTitleValue() -> String {
		switch self {
		case .randomImages:
			return L10n.TabBar.favoriteImagesTitle
		case .favoriteImages:
			return L10n.TabBar.randomImagesTitle
		}
	}
	
	func pageIconValue() -> UIImage {
		switch self {
		case .randomImages:
			return Images.image(kind: .list)
		case .favoriteImages:
			return Images.image(kind: .chart)
		}
	}
	
	static let allTabbarPages: [TabbarPage] = [.randomImages, .favoriteImages]
	static let firstTabbarPage: TabbarPage = .randomImages
	
	var pageOrderNumber: Int {
		guard let num = TabbarPage.allTabbarPages.firstIndex(of: self) else { return .zero }
		return num
	}
}
