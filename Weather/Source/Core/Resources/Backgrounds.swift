//
//  Untitled.swift
//  Weather
//
//  Created by Alexey Kiparin on 26.12.2024.
//

import UIKit

final public class Backgrounds {
	
	public static func getBackground() -> UIImage {
		let currentDate = Date()
			let calendar = Calendar.current
			let hour = calendar.component(.hour, from: currentDate)
			let month = calendar.component(.month, from: currentDate)
			
			// Определение времени суток
			let timeOfDay: String
			if hour >= 6 && hour < 18 {
				timeOfDay = "День"
			} else {
				timeOfDay = "Ночь"
			}
			
			// Определение сезона
			switch month {
			case 3, 4, 5:
				if timeOfDay == "День" {
					return UIImage(named: "SpringDay") ?? UIImage()
				}
				else {
					return UIImage(named: "SpringNight") ?? UIImage()
				}
			case 6, 7, 8:
				if timeOfDay == "День" {
					return UIImage(named: "SummerDay") ?? UIImage()
				}
				else {
					return UIImage(named: "SummerNight") ?? UIImage()
				}
			case 9, 10, 11:
				if timeOfDay == "День" {
					return UIImage(named: "FallDay") ?? UIImage()
				}
				else {
					return UIImage(named: "FallNight") ?? UIImage()
				}
			case 12, 1, 2:
				if timeOfDay == "День" {
					return UIImage(named: "SnowDay") ?? UIImage()
				}
				else {
					return UIImage(named: "SnowNight") ?? UIImage()
				}
			default:
				return UIImage(named: "SummerDay") ?? UIImage()
			}
	}
}
