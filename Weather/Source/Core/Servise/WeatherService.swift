//
//  WeatherService.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import Foundation

public final class WeatherService {
	
	var delegate: DataReceiver?
	
	private let api: NetworkManager = NetworkManager.shared
	
	public func fetchWeather(_ latitude: Double,_ longitude: Double) {
		
		let data = UserData(
			Latitude: latitude,
			Longitude: longitude,
			StartDate: Date(),
			EndDate: Date(),
			Dayly: [.temperature_2m_max, .temperature_2m_min],
			Current: [.temperature_2m ,.is_day , .weather_code]
		)
		
		api.fetchWeatherNow(data) { result in
			switch result {
			case .success(let currentWeather):
				print("Полученная погода: \(currentWeather)")
				DispatchQueue.main.async {
					self.delegate?.success(currentWeather)
				}
			case .failure(let error):
				print("Не удалось получить данные о погоде. \(error.localizedDescription)")
				DispatchQueue.main.async {
					self.delegate?.failure("Не удалось получить данные о погоде.")
				}
			}
		}
	}
	
	public func fetchWeatherOnWeek(_ latitude: Double,_ longitude: Double) {
		
		let data = UserData(
			Latitude: latitude,
			Longitude: longitude,
			Dayly: [.temperature_2m_max, .temperature_2m_min]
		)
		
		api.fetchWeatherOfWeek(data) { result in
			switch result {
			case .success(let weatherOfWeek):
				print("Полученная погода: \(weatherOfWeek)")
				DispatchQueue.main.async {
					self.delegate?.success(weatherOfWeek)
				}
			case .failure(let error):
				print("Не удалось получить данные о погоде. \(error.localizedDescription)")
				DispatchQueue.main.async {
					self.delegate?.failure("Не удалось получить данные о погоде на неделю.")
				}
			}
		}
	}
	
	public func fetchImage(_ url: URL) {
		
		api.fetchImage(from: url){ result in
			switch result {
			case .success(let image):
				print("Полученная изображение: \(image)")
				DispatchQueue.main.async {
					self.delegate?.success(image)
				}
			case .failure(_):
				DispatchQueue.main.async {
					self.delegate?.failure("Не удалось получить изображение.")
				}
			}
		}
	}
}
