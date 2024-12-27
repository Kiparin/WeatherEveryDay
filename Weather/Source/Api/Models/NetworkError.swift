//
//  NetworkError.swift
//  Weather
//
//  Created by Alexey Kiparin on 25.12.2024.
//

public enum NetworkError: Error {
	case invalidURL
	case noData
	case decodingError
}
