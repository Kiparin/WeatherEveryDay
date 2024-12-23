//
//  MapperService.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

final class MapperService {
	static func mapToWeatherBaseOneDay(from: WeatherResponceDTO) -> WeatherBase {
		WeatherBase(
			TimeZone: from.timezone,
			TemperatureType: from.daily_units!.temperature_2m_max ?? "",
			TemperatureDay: from.daily!.temperature_2m_max!.first ?? 0,
			TemperatureNight: from.daily!.temperature_2m_min!.first ?? 0
		)
	}
}
