//
//  WeatherApiService.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import Foundation

public final class WeatherApiService {
	
	public func fetchWeatherOfDay(_ data: UserData, completion: @escaping (WeatherBase?) -> Void) {
		let urlRequest = URLConstructor.makeURL(data)
		print("Request: \(urlRequest)")
		
		URLSession.shared.dataTask(with: urlRequest) {[weak self] data,_,error in
			guard self != nil else { return }
			guard let data else {
				print("Error: \(error?.localizedDescription ?? "Unknown error")")
				return completion(nil)
			}
			do {
				let response	= try JSONDecoder().decode(WeatherResponceDTO.self, from: data)
				print("Response: \(response)")
				completion(MapperService.mapToWeatherBaseOneDay(from: response))
				
			} catch {
				print("Error: \(error)")
				completion(nil)
			}
		}.resume()
	}
}
