//
//  StormDetailView.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import SwiftUI

struct StormDetailView: View {
    let storm: StormEntry
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let data = storm.imageData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
                
                Text(storm.stormType)
                    .font(.title.bold())
                
                Text(storm.notes)
                    .font(.body)
                
                Group {
                    Text("Captured: \(storm.date.formatted(date: .abbreviated, time: .shortened))")
                    Text("Latitude: \(storm.latitude, specifier: "%.4f")")
                    Text("Longitude: \(storm.longitude, specifier: "%.4f")")
                    
                    if let temp = storm.temperature {
                        Text("Temperature: \(Int(temp))°C")
                    }
                    if let wind = storm.windSpeed {
                        Text("Wind Speed: \(String(format: "%.1f", wind)) m/s")
                    }
                    if let precip = storm.precipitation {
                        Text("Precipitation: \(String(format: "%.1f", precip)) mm")
                    }
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding()
        }
        .navigationTitle("Storm Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
