//
//  Image.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 10.02.2024.
//

import Foundation

struct Image: Codable {
	var id: String
	var altDescription: String
	var urls: Urls
	var links: LinksImage
	
	enum CodingKeys: String, CodingKey {
		case id
		case altDescription = "alt_description"
		case urls, links
	}
}
struct Urls: Codable {
	var raw, full, regular, small: String
	var thumb, smallS3: String
	
	enum CodingKeys: String, CodingKey {
		case raw, full, regular, small, thumb
		case smallS3 = "small_s3"
	}
}

struct LinksImage: Codable {
	var linksSelf, html, download, downloadLocation: String
	
	enum CodingKeys: String, CodingKey {
		case linksSelf = "self"
		case html, download
		case downloadLocation = "download_location"
	}
}
