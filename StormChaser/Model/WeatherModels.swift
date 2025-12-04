//
//  WeatherModels.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation

struct WeatherData: Identifiable {
    let id = UUID()
    let temperature: Double
    let windSpeed: Double
    let precipitation: Double
    let description: String
}

struct OpenMeteoResponse: Decodable {
    struct Current: Decodable {
        let temperature_2m: Double
        let wind_speed_10m: Double
        let precipitation: Double
    }
    
    let current: Current
}
