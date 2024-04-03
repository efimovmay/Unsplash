//
//  UIImageView+load+cache.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 01.04.2024.
//

import UIKit

var imageCahe = NSCache<AnyObject, AnyObject>()

extension UIImageView {
	func load(urlString: String) {
		
		if let image = imageCahe.object(forKey: urlString as NSString) as? UIImage {
			self.image = image
			return
		}
		
		guard let url = URL(string: urlString) else {
			return
		}
		
		DispatchQueue.global().async { [weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						imageCahe.setObject(image, forKey: urlString as NSString)
						self?.image = image
					}
				}
			}
		}
	}
}
