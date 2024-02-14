//
//  Image.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

struct Image: Codable {
	var createdAt: String
	var urls: Urls
	var links: LinksImage
	var user: User
	var location: Location?
	var likes: Int?
	
	enum CodingKeys: String, CodingKey {
		case createdAt = "created_at"
		case urls
		case links
		case location
		case user
		case likes
	}
}

struct Location: Codable {
	var name: String
	
	enum CodingKeys: String, CodingKey {
		case name
	}
}

struct User: Codable {
	var name: String
	
	enum CodingKeys: String, CodingKey {
		case name
	}
}

struct Urls: Codable {
	var raw: String
	var	full: String
	var regular: String
	var small: String
	var thumb: String
	var smallS3: String
	
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
	var linksSelf: String
	var html: String
	var download: String
	
	enum CodingKeys: String, CodingKey {
		case linksSelf = "self"
		case html
		case	 download
	}
}
