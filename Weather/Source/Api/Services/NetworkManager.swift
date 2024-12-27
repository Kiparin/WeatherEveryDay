//
//  WeatherApiService.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import Foundation

public final class NetworkManager {
	
	public static let shared = NetworkManager()
	
	private init() {}
	
	func fetchImage(from url: URL,completion: @escaping (Swift.Result<Data, NetworkError>) -> Void
	) {
		DispatchQueue.global().async {
			guard let data = try? Data(contentsOf: url) else {
				completion(.failure(.noData))
				return
			}
			DispatchQueue.main.async {
				completion(.success(data))
			}
		}
	}
	
	public func fetchWeatherNow(_ userData : UserData, completion: @escaping (Result<CurrentWeather, NetworkError>) -> Void){
		let url = URLConstructor.makeURL(userData)
		
		fetch(WeatherResponceDTO.self, from: url) { result in
			switch result {
			case .success(let response):
				completion(.success(MapperService.mapToCurrentWeather(from: response)))
			case .failure(_):
				completion(.failure(.decodingError))
			}
		}
	}
	
	public func fetchWeatherOfWeek(_ userData : UserData, completion: @escaping (Result<WeatherOfWeek, NetworkError>) -> Void){
		let url = URLConstructor.makeURL(userData)
		
		fetch(WeatherResponceDTO.self, from: url) { result in
			switch result {
			case .success(let response):
				completion(.success(MapperService.mapToForecastWeather(from: response))
				)
			case .failure(_):
				completion(.failure(.decodingError))
			}
		}
		
		
	}
	
	private func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
		URLSession.shared.dataTask(with: url) { data, _, error in
			guard let data else {
				print(error?.localizedDescription ?? "No error description")
				completion(.failure(.noData))
				return
			}
			
			do {
				let decoder = JSONDecoder()
				let dataModel = try decoder.decode(T.self, from: data)
				DispatchQueue.main.async {
					completion(.success(dataModel))
				}
			} catch {
				print(error.localizedDescription)
				completion(.failure(.decodingError))
			}
			
		}.resume()
	}
}
