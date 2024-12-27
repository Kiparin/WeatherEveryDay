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
	let daily_units: UnitsDTO?
	let hourly_units: UnitsDTO?
	let current_units: UnitsDTO?
	let daily: ResultDTO?
	let hourly: ResultDTO?
	let current: CurentDTO?
}

struct UnitsDTO: Decodable {
	let time: String?
	let temperature_2m_max: String?
	let temperature_2m_min: String?
	let temperature_2m: String?
}

struct ResultDTO: Decodable {
	let time: [String]?
	let temperature_2m_max: [Double]?
	let temperature_2m_min: [Double]?
	let temperature_2m: [Double]?
}

struct CurentDTO: Decodable {
	let time: String?
	let interval: UInt?
	let temperature_2m: Double?
	let is_day: UInt8?
	let weather_code: UInt8?
}
