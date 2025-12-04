//
//  WeatherView.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var locationService: LocationService
    @StateObject private var viewModel = WeatherViewModel(weatherService: WeatherService())
    
    var body: some View {
        VStack(spacing: 16) {
            switch viewModel.state {
                case .idle:
                    Text("Waiting for location…")
                    
                case .loading:
                    ProgressView("Loading weather…")
                    
                case .loaded(let data):
                    VStack(spacing: 12) {
                        Text("Current Weather").font(.title.bold())
                        Text("Temperature: \(Int(data.temperature))°C")
                        Text("Wind Speed: \(String(format: "%.1f", data.windSpeed)) m/s")
                        Text("Precipitation: \(String(format: "%.1f", data.precipitation)) mm")
                    }
                    .padding()
                    
                case .failed(let message):
                    NotFoundView(message: message) {
                        Task {
                            if let loc = locationService.lastLocation {
                                await viewModel.loadWeather(for: loc)
                            }
                        }
                    }
            }
        }
        .padding()
        .navigationTitle("Storm Chaser")
        .onAppear {
            locationService.requestAuthorizationIfNeeded()
        }
        .onReceive(locationService.$lastLocation.compactMap { $0 }) { location in
            Task { await viewModel.loadWeather(for: location) }
        }
    }
}
