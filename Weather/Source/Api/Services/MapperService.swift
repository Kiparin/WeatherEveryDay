//
//  MapperService.swift
//  Weather
//
//  Created by Alexey Kiparin on 23.12.2024.
//

final class MapperService {
	static func mapToCurrentWeather(from: WeatherResponceDTO) -> CurrentWeather {
		CurrentWeather(
			TimeZone: from.timezone,
			TemperatureType: from.daily_units!.temperature_2m_max ?? "",
			TemperatureDay: from.daily!.temperature_2m_max!.first ?? 0,
			TemperatureNight: from.daily!.temperature_2m_min!.first ?? 0,
			TemperatureNow: from.current!.temperature_2m ?? 0,
			IsDay: from.current!.is_day == 1 ? true : false,
			WeatherCode: from.current!.weather_code ?? 0
		)
	}
	
	static func mapToForecastWeather(from: WeatherResponceDTO) -> WeatherOfWeek {
		WeatherOfWeek(
			TemperatureType: from.daily_units!.temperature_2m_max ?? "",
			DayliTime: from.daily!.time ?? [],
			DailyTemperatureMax: from.daily!.temperature_2m_max ?? [],
			DailyTemperatureMin: from.daily!.temperature_2m_min ?? []
		)
	}
}
