//
//  WeatherViewModel.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation
import CoreLocation

@MainActor
final class WeatherViewModel: ObservableObject {
    
    enum State {
        case idle
        case loading
        case loaded(WeatherData)
        case failed(String)
    }
    
    @Published private(set) var state: State = .idle
    
    private let weatherService: WeatherServicing
    
    /// Track last loaded coordinate
    private var lastLoadedCoordinate: CLLocationCoordinate2D?
    
    init(weatherService: WeatherServicing) {
        self.weatherService = weatherService
    }
    
    func loadWeather(for location: CLLocation) async {
        let coord = location.coordinate
        
        // Prevent duplicate reload if same coordinate
        if let last = lastLoadedCoordinate,
           last.latitude == coord.latitude,
           last.longitude == coord.longitude {
            return
        }
        
        lastLoadedCoordinate = coord
        state = .loading
        
        do {
            let data = try await weatherService.fetchCurrentWeather(for: location)
            state = .loaded(data)
        } catch is CancellationError {
            // Ignore cancellations from SwiftUI redraw
            return
        } catch {
            state = .failed("Failed to fetch weather: \(error.localizedDescription)")
        }
    }
    
    /// Retry button forces reload even if coordinate is same
    func retry(location: CLLocation?) async {
        guard let location else {
            state = .failed("Location not available")
            return
        }
        
        // Allow reloading for same coordinate
        lastLoadedCoordinate = nil
        
        await loadWeather(for: location)
    }
}
