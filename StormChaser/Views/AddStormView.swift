//
//  AddStormView.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import SwiftUI
import SwiftData
import CoreLocation

struct AddStormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var locationService: LocationService
    
    @StateObject private var viewModel = StormFormViewModel()
    
    // For photo picker
    @State private var showPhotoSourceChooser = false
    @State private var showImagePicker = false
    @State private var selectedSource: ImagePicker.SourceType = .camera
    
    // Weather will be injected later if needed
    let currentWeather: WeatherData? = nil
    
    var body: some View {
        Form {
            // MARK: - Photo Section
            Section("Photo") {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .onTapGesture {
                            showPhotoSourceChooser = true
                        }
                } else {
                    Button {
                        showPhotoSourceChooser = true
                    } label: {
                        Label("Capture/Select Photo", systemImage: "camera")
                    }
                }
            }
            
            // MARK: - Storm Info Section
            Section("Storm Info") {
                TextField("Storm type (e.g. Thunderstorm)", text: $viewModel.stormType)
                TextField("Notes / Description", text: $viewModel.notes, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
            }
            
            // MARK: - Location Section
            Section("Location") {
                if let loc = locationService.lastLocation {
                    Text("Latitude: \(loc.coordinate.latitude, specifier: "%.4f")")
                    Text("Longitude: \(loc.coordinate.longitude, specifier: "%.4f")")
                } else {
                    Text("Location not available")
                        .foregroundStyle(.secondary)
                }
            }
            
            // MARK: - Error message
            if let error = viewModel.errorMessage {
                Section {
                    Text(error)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationTitle("New Storm")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.save(
                        weather: currentWeather,
                        location: locationService.lastLocation,
                        context: context
                    )
                    if viewModel.errorMessage == nil {
                        dismiss()
                    }
                }
                .disabled(viewModel.selectedImage == nil)
            }
        }
        
        // MARK: - Photo Source ActionSheet
        .confirmationDialog("Select Photo Source", isPresented: $showPhotoSourceChooser, titleVisibility: .visible) {
            Button("Take Photo") {
                selectedSource = .camera
                showImagePicker = true
            }
            Button("Choose from Library") {
                selectedSource = .photoLibrary
                showImagePicker = true
            }
            Button("Cancel", role: .cancel) { }
        }
        
        // MARK: - Image Picker
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: selectedSource, image: $viewModel.selectedImage)
        }
    }
}
