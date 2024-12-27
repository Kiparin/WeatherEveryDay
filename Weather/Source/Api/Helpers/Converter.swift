//
//  Converter.swift
//  Weather
//
//  Created by Alexey Kiparin on 26.12.2024.
//
import Foundation

public final class Converter {
	static func formatDateString(_ dateString: String) -> String? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		if let date = dateFormatter.date(from: dateString) {
			dateFormatter.locale = Locale(identifier: "ru_RU")
			dateFormatter.dateFormat = "d MMMM yyyy"
			return dateFormatter.string(from: date)
		} else {
			return nil
		}
	}
}
