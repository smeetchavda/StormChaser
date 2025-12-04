//
//  StormFormViewModel.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation
import SwiftUI
import SwiftData
import CoreLocation

@MainActor
final class StormFormViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var stormType: String = ""
    @Published var notes: String = ""
    @Published var isSaving: Bool = false
    @Published var errorMessage: String?
    
    func save(
        weather: WeatherData?,
        location: CLLocation?,
        context: ModelContext
    ) {
        guard let location else {
            errorMessage = "Location not available"
            return
        }
        
        isSaving = true
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        
        let entry = StormEntry(
            imageData: imageData,
            temperature: weather?.temperature,
            windSpeed: weather?.windSpeed,
            precipitation: weather?.precipitation,
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude,
            notes: notes,
            stormType: stormType.isEmpty ? "Unknown" : stormType
        )
        
        context.insert(entry)
        do {
            try context.save()
            isSaving = false
        } catch {
            isSaving = false
            errorMessage = "Failed to save: \(error.localizedDescription)"
        }
    }
}
