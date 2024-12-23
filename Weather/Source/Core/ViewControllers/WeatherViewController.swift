//
//  ViewController.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import UIKit

protocol DataReceiver {
	func success(_ weather: WeatherBase)
	func failure(_ error: String)
}

final class WeatherViewController: UIViewController {
	private let weatherService = WeatherService()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		weatherService.delegate = self
	}
	
	@IBAction func refreshButtonTapped() {
		weatherService.fetchWeather()
	}
}

extension WeatherViewController: DataReceiver {
	func success(_ weather: WeatherBase) {
		showAlert(
			title: "Погода на сегодня",
			message: "Временная зона: \(weather.TimeZone)\nТемпература днем (Макс): \(weather.TemperatureDay)\(weather.TemperatureType)\nТемпература ночью (Мин): \(weather.TemperatureNight)\(weather.TemperatureType)\n")
	}
	
	func failure(_ error: String) {
		self.showAlert(
			title: "Ошибка",
			message: error)
	}
	
	private func showAlert(title: String, message: String) {
		DispatchQueue.main.async {
			let alert = UIAlertController(
				title: title,
				message: message,
				preferredStyle: .alert
			)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		}
	}
}

