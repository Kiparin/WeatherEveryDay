//
//  URLConstructor.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import Foundation

final class URLConstructor {
	
	public static func makeURL(_ data: UserData) -> URL {
		var urlResult = "https://api.open-meteo.com/v1/forecast?"
		
		urlResult.append("latitude=\(data.Latitude)&longitude=\(data.Longitude)")
		
		if data.Hourly != nil {
			let result = makeWeatherParemeter(data.Hourly!, "&hourly=")
			urlResult.append(result)
		}
		
		if data.Dayly != nil {
			let result = makeWeatherParemeter(data.Dayly!, "&daily=")
			urlResult.append(result)
		}
		
		if data.ForecastDays != nil {
			urlResult.append("&forecast_days=\(data.ForecastDays!)")
		}
		
		if data.Timezone != nil {
			urlResult.append("&timezone=\(data.Timezone!)")
		}
		
		if data.StartDate != nil {
			urlResult.append("&start_date=\(dateFormat(data.StartDate!))")
		}
		
		if data.EndDate != nil {
			urlResult.append("&end_date=\(dateFormat(data.EndDate!))")
		}
		
		print("Make URL: \(urlResult)")
		
		return URL(string: urlResult)!;
	}
	
	private static func makeWeatherParemeter(_ data: [WeatherParameters], _ parameter: String) -> String {
		var itemResult = parameter
		for item in data {
			itemResult.append("\(item),")
		}
		itemResult.removeLast()
		
		return itemResult
	}
	
	private static func dateFormat(_ data: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		return dateFormatter.string(from: data)
	}
}
