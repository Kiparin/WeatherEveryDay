//
//  WeatherResponce.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

struct WeatherResponceDTO: Decodable {
	let latitude: Double
	let longitude: Double
	let timezone: String
	let timezone_abbreviation: String
	let daily_units: Units?
	let hourly_units: Units?
	let daily: Result?
	let hourly: Result?
}

struct Units: Decodable {
	let time: String?
	let temperature_2m_max: String?
	let temperature_2m_min: String?
	let temperature_2m: String?
}

struct Result: Decodable {
	let time: [String]?
	let temperature_2m_max: [Double]?
	let temperature_2m_min: [Double]?
	let temperature_2m: [Double]?
}
