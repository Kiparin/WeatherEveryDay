//
//  WeatherService.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import Foundation

public final class WeatherService {
	
	var delegate: DataReceiver?
	
	//этот объект должен заполняться телефоном ( GPS services IOS)
	//потому пока что он проинициалирован так 
	private let userWeather: UserData = UserData(
		Latitude: 56.2819,
		Longitude: 44.0375,
		StartDate: Date(),
		EndDate: Date(),
		Dayly: [.temperature_2m_max,.temperature_2m_min]
	)
	
	private let api: WeatherApiService = WeatherApiService()
	
	public func fetchWeather() {
		api.fetchWeatherOfDay(userWeather) { weatherBase in
			if let weather = weatherBase {
				// Обрабатываем полученные данные о погоде
				print("Полученная погода: \(weather)")
				self.delegate?.success(weather)
			} else {
				// Обрабатываем ошибку
				print("Не удалось получить данные о погоде.")
				self.delegate?.failure("Не удалось получить данные о погоде.")
			}
		}
	}
}
