//
//  NetworkManager.swift
//  Unsplash
//
//  Created by Aleksey Efimov on 12.02.2024.
//

import Foundation
import Alamofire

enum Links: String {
	case baseURL = "https://api.unsplash.com/"
	case randomURL = "photos/random"
	case screach = "search/photos"
	case token = "V6cwuYNnawqaMwzwfUkpvtBsy0nXk5_zvJd1er6smoc"
}

protocol INetworkManager {
	
	/// Загрузка данных изображения
	/// - Parameter link: строка URL изображения.
	func fetchImage(link: String, completion: @escaping(Result<Image, AFError>) -> Void)
	
	/// Загрузка массива данных изображений
	/// - Parameter secondUrl: строка URL изображения.
	/// - Parameter parameter: параметр для загрузки.
	func fetchImages(
		secondUrl: String,
		parametersUrl: Parameters,
		completion: @escaping(Result<[Image], AFError>) -> Void
	)
	
	/// Загрузка изображения в формате Data
	/// - Parameter url: строка URL изображения.
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
	
	func fetchImages(
		secondUrl: String,
		parametersUrl: Parameters,
		completion: @escaping(Result<[Image], AFError>) -> Void
	) {

		let fullURL = Links.baseURL.rawValue + secondUrl
		guard let link = URL(string: Links.baseURL.rawValue) else { return }

		AF.request(
			fullURL,
			method: .get,
			parameters: parametersUrl
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
