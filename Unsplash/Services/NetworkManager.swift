//
//  NetworkManager.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 12.02.2024.
//

import Foundation
import Alamofire

enum Links: String {
	case randomURL = "https://api.unsplash.com/photos/random"
	case searchURL = "https://api.unsplash.com/search/photos"
	case token = "V6cwuYNnawqaMwzwfUkpvtBsy0nXk5_zvJd1er6smoc"
}

enum ParametersUrl: String {
	case clientId = "client_id"
	case count = "count"
	case query = "query"
}

protocol INetworkManager {
	
	/// Загрузка данных о изображении
	/// - Parameter link: строка URL изображения.
	func fetchImage(link: String, completion: @escaping(Result<Image, AFError>) -> Void)
	
	/// Загрузка данных изображений по поиску
	/// - Parameter seachBy: текст для поиска
	func fetchSearchImages(searchBy: String, completion: @escaping(Result<[Image], AFError>) -> Void)
	
	/// Загрузка данных случайных изображений
	func fetchRandomImages(completion: @escaping(Result<[Image], AFError>) -> Void)
	
	/// Загрузка изображения в формате Data
	/// - Parameter url: строка URL изображения.
	func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void)
}

final class NetworkManager: INetworkManager {
	
	func fetchImage(link: String, completion: @escaping(Result<Image, AFError>) -> Void) {
		AF.request(
			link,
			method: .get,
			parameters: [ParametersUrl.clientId.rawValue: Links.token.rawValue]
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
	
	func fetchSearchImages(searchBy: String, completion: @escaping(Result<[Image], AFError>) -> Void) {
		AF.request(
			Links.searchURL.rawValue,
			method: .get,
			parameters: [ParametersUrl.clientId.rawValue: Links.token.rawValue, ParametersUrl.query.rawValue: searchBy]
		)
		.validate()
		.responseDecodable(of: SearchResult.self) { response in
			switch response.result {
			case .success(let value):
				completion(.success(value.results))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func fetchRandomImages(completion: @escaping(Result<[Image], AFError>) -> Void) {
		let numberImages = 12
		AF.request(
			Links.randomURL.rawValue,
			method: .get,
			parameters: [ParametersUrl.clientId.rawValue: Links.token.rawValue, ParametersUrl.count.rawValue: numberImages]
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
