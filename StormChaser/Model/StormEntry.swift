//
//  StormEntry.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation
import SwiftData

@Model
final class StormEntry {
    @Attribute(.unique) var id: UUID
    var imageData: Data?
    var temperature: Double?
    var windSpeed: Double?
    var precipitation: Double?
    var latitude: Double
    var longitude: Double
    var date: Date
    var notes: String
    var stormType: String
    
    init(
        id: UUID = UUID(),
        imageData: Data?,
        temperature: Double?,
        windSpeed: Double?,
        precipitation: Double?,
        latitude: Double,
        longitude: Double,
        date: Date = Date(),
        notes: String,
        stormType: String
    ) {
        self.id = id
        self.imageData = imageData
        self.temperature = temperature
        self.windSpeed = windSpeed
        self.precipitation = precipitation
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
        self.notes = notes
        self.stormType = stormType
    }
}
