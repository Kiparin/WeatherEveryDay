//
//  ViewController.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import UIKit
import CoreLocation

//MARK: Protocol of Data
protocol DataReceiver {
	func success(_ weather: CurrentWeather)
	func success(_ weather: WeatherOfWeek)
	func success(_ imageData: Data)
	func failure(_ error: String)
}

final class WeatherViewController: UIViewController{
	
	//MARK: Outlets
	@IBOutlet weak var weatherImage: UIImageView!
	@IBOutlet weak var weatherNowLable: UILabel!
	@IBOutlet weak var weatherDayMax: UILabel!
	@IBOutlet weak var weatherNightMin: UILabel!
	@IBOutlet weak var weatherDiscription: UILabel!
	@IBOutlet weak var weatherOfWeekCollection: UICollectionView!
	@IBOutlet weak var background: UIImageView!
	
	//MARK: Private Fields
	private var locationManager: CLLocationManager!
	private let weatherService = WeatherService()
	private var waetherOfWeek: WeatherOfWeek?
	
	//MARK: LifeCircle
	override func viewDidLoad() {
		super.viewDidLoad()
		background.image = Backgrounds.getBackground()
		
		weatherService.delegate = self
		weatherOfWeekCollection.dataSource = self
		weatherOfWeekCollection.delegate = self
		
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		
	}
	
	private func loadData(_ latitude: Double,_ longitude: Double) {
		weatherService.fetchWeather(latitude, longitude)
		weatherService.fetchWeatherOnWeek(latitude, longitude)
	}
}

//MARK: DataLoad
extension WeatherViewController: DataReceiver {
	func success(_ imageData: Data) {
		let image = UIImage(data: imageData)
		weatherImage.image = image
	}
	
	func success(_ weather: WeatherOfWeek) {
		waetherOfWeek = weather
		weatherOfWeekCollection.reloadData()
	}
	
	func success(_ weather: CurrentWeather) {
		
		let discription = WeatherCodeServices.getDataByCode(weather.WeatherCode,weather.IsDay)
		weatherService.fetchImage(discription!.image)// Я точно знаю на что иду)))
		
		if weather.IsDay {
			overrideUserInterfaceStyle = .light
		}
		else {
			overrideUserInterfaceStyle = .dark
		}
		
		DispatchQueue.main.async {
			self.weatherNowLable.text = "\(weather.TemperatureNow)\(weather.TemperatureType)"
			self.weatherDayMax.text = "\(weather.TemperatureDay)\(weather.TemperatureType)"
			self.weatherNightMin.text = "\(weather.TemperatureNight)\(weather.TemperatureType)"
			self.weatherDiscription.text = discription?.description
		}
	}
	
	func failure(_ error: String) {
		self.showAlert(title: "Ошибка",message: error)
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

//MARK: CollectionView
extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		waetherOfWeek?.DailyTemperatureMax.count ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherOfWeekCell", for: indexPath) as! WeatherOfWeekViewCell
		
		cell.dateLable.text = Converter.formatDateString(waetherOfWeek?.DayliTime[indexPath.row] ?? "")
		cell.dayMax.text = String(waetherOfWeek?.DailyTemperatureMax[indexPath.row] ?? 0)+"\(waetherOfWeek?.TemperatureType ?? "")"
		cell.nightMin.text = String(waetherOfWeek?.DailyTemperatureMin[indexPath.row] ?? 0)+"\(waetherOfWeek?.TemperatureType ?? "")"
		return cell
	}
}

//MARK: LocationLoadData
extension WeatherViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last {
			let latitude = location.coordinate.latitude
			let longitude = location.coordinate.longitude
			
			self.loadData(Double(latitude), Double(longitude))
			print("Текущее местоположение: \(latitude), \(longitude))")
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Ошибка получения местоположения: \(error.localizedDescription)")
	}
}
