//
//  NetworkManager.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 12.02.2024.
//

import Foundation
import Alamofire

enum Links: String {
	case baseURL = "https://api.unsplash.com/photos/random"
	case token = "V6cwuYNnawqaMwzwfUkpvtBsy0nXk5_zvJd1er6smoc"
}

protocol INetworkManager {
	func fetchImage(link: String, completion: @escaping(Result<Image, AFError>) -> Void)
	func fetchImages(completion: @escaping(Result<[Image], AFError>) -> Void)
	func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void)
}

final class NetworkManager: INetworkManager {
	
	func fetchImage(link: String, completion: @escaping(Result<Image, AFError>) -> Void) {
		AF.request(
			link,
			method: .get,
			parameters: ["client_id": Links.token.rawValue]
		)
		.validate()
		.responseDecodable(of: Image.self) { response in
			switch response.result {
			case .success(let value):
				completion(.success(value))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func fetchImages(completion: @escaping(Result<[Image], AFError>) -> Void) {
		let numberImage = 12
		guard let link = URL(string: Links.baseURL.rawValue) else { return }
		
		AF.request(
			link,
			method: .get,
			parameters: ["client_id": Links.token.rawValue, "count": numberImage]
		)
			.validate()
			.responseDecodable(of: [Image].self) { response in
				switch response.result {
				case .success(let value):
					completion(.success(value))
				case .failure(let error):
					completion(.failure(error))
				}
			}
	}
	
	func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
		AF.request(url)
			.validate()
			.responseData { response in
				switch response.result {
				case .success(let imageData):
					completion(.success(imageData))
				case .failure(let error):
					completion(.failure(error))
				}
			}
	}
}
