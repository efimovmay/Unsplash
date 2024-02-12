//
//  Image.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

struct Image {
	let id: String
	let altDescription: String
	let urls: Urls
	let links: Links
	
	struct Urls {
		let full: String
		let regular: String
		let small: String
	}
	
	struct Links {
		let html: String
	}
}
