//
//  WNOCode.swift
//  Weather
//
//  Created by Alexey Kiparin on 25.12.2024.
//

import Foundation

// MARK: - WNOCode
public struct WMOCode: Codable {
	let elements: [Element]
}

// MARK: - Element
public struct Element: Codable {
	let code: UInt8
	let data: WMOData
}

// MARK: - DataClass
public struct WMOData: Codable {
	let day, night: Info
}

// MARK: - Day
public struct Info: Codable {
	let description: String
	let image: URL
}
