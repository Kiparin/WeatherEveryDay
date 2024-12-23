//
//  DataContext.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

import Foundation

public struct UserData {
	public var Latitude: Double
	public var Longitude: Double
	public var Timezone: String?
	public var ForecastDays: UInt?
	public var StartDate: Date?
	public var EndDate: Date?
	public var Dayly: [WeatherParameters]?
	public var Hourly: [WeatherParameters]?
}
