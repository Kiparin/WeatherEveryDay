//
//  WeatherCodeServices.swift
//  Weather
//
//  Created by Alexey Kiparin on 25.12.2024.
//

import Foundation

public final class WeatherCodeServices {
	
	private static let code: WMOCode = try! JSONDecoder().decode(
		WMOCode.self,
		from: Data(
			contentsOf: Bundle.main.url(forResource: "WeatherCodeFile", withExtension: "json")!
		)
	)
	
	public init() {}
	
	public static func getDataByCode(_ idcode: UInt8, _ isDay: Bool) -> Info? {
		let element = code.elements.first(where: { $0.code == idcode })
		if isDay {
			return element?.data.day ?? nil
		} else {
			return element?.data.night ?? nil
		}
	}
}
