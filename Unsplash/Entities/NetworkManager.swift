//
//  NetworkManager.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 12.02.2024.
//

import Foundation
import Alamofire

enum Links: String {
	case baseURL = "https://api.unsplash.com/photos"
	case token = "V6cwuYNnawqaMwzwfUkpvtBsy0nXk5_zvJd1er6smoc"
}

protocol INetworkManager {
	func fetchImages(completion: @escaping(Result<[Image], AFError>) -> Void)
	func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void)
}

final class NetworkManager: INetworkManager {
	
	func fetchImages(completion: @escaping(Result<[Image], AFError>) -> Void) {
		let link = URL(string: Links.baseURL.rawValue)
		guard let fullLink = link else { return }
		
		AF.request(
			fullLink,
			method: .get,
			parameters: ["client_id": Links.token.rawValue]
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
