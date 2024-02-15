//
//  Image.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

struct SearchResult: Codable {
	let results: [Image]
	
	enum CodingKeys: String, CodingKey {
		case results
	}
}

struct Image: Codable {
	let createdAt: String?
	let urls: Urls
	let links: LinksImage
	let user: User
	let location: Location?
	let downloads: Int?
	
	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case urls
		case links
		case location
		case user
		case downloads
	}
}

struct Location: Codable {
	let name: String?
	
	enum CodingKeys: String, CodingKey {
		case name
	}
}

struct User: Codable {
	let name: String?
	
	enum CodingKeys: String, CodingKey {
		case name
	}
}

struct Urls: Codable {
	let raw: String
	let	full: String
	let regular: String
	let small: String
	let thumb: String
	let smallS3: String
	
	enum CodingKeys: String, CodingKey {
		case raw
		case full
		case	 regular
		case small
		case thumb
		case smallS3 = "small_s3"
	}
}

struct LinksImage: Codable {
	let linksSelf: String
	let html: String
	let download: String
	
	enum CodingKeys: String, CodingKey {
		case linksSelf = "self"
		case html
		case	 download
	}
}
