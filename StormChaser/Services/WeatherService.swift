//
//  WeatherService.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation
import CoreLocation

protocol WeatherServicing {
    func fetchCurrentWeather(for location: CLLocation) async throws -> WeatherData
}

struct WeatherService: WeatherServicing {
    func fetchCurrentWeather(for location: CLLocation) async throws -> WeatherData {
        var components = URLComponents(string: "https://api.open-meteo.com/v1/forecast")!
        components.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "current", value: "temperature_2m,precipitation,wind_speed_10m")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
        
        return WeatherData(
            temperature: decoded.current.temperature_2m,
            windSpeed: decoded.current.wind_speed_10m,
            precipitation: decoded.current.precipitation,
            description: "Temp: \(decoded.current.temperature_2m)°C"
        )
    }
}
