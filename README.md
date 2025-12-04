# StormChaser – Speer Technologies Mobile Assessment

A SwiftUI + MVVM-C iOS application for storm-chasing hobbyist meteorologists.
Users can:
- View current weather at their location (Open-Meteo API)
- Capture storm photos with metadata (location, date/time, notes, storm type)
- Persist storms locally using SwiftData
- Navigate between Weather and Storms sections with a lightweight Coordinator layer

## Tech Stack

- iOS, Swift 5, SwiftUI
- Architecture: MVVM-C (Model–View–ViewModel–Coordinator)
- Persistence: SwiftData
- Location: CoreLocation + custom LocationService
- Networking: URLSession with a `WeatherServicing` protocol
- Camera: `UIImagePickerController` bridged via `UIViewControllerRepresentable`
- Unit Testing: XCTest (WeatherViewModel test with mock service)

## Architecture Overview

- **Models**
  - `StormEntry` (SwiftData model)
  - `WeatherData`, `OpenMeteoResponse`
- **Services**
  - `WeatherService : WeatherServicing`
  - `LocationService` (CoreLocation wrapper)
- **ViewModels**
  - `WeatherViewModel` – loads weather using `WeatherServicing`
  - `StormListViewModel` – list management and deletion
  - `StormFormViewModel` – handles form state and saving storms
- **Coordinators**
  - `AppCoordinator` – controls selected tab (Weather vs Storms)
  - `StormCoordinator` – controls presentation of the Add Storm sheet
- **Views**
  - `ContentView` – root TabView with two NavigationStacks
  - `WeatherView` – current weather and “View Documented Storms” CTA
  - `StormListView` – list of persisted storms
  - `AddStormView` – camera, metadata form, and save
  - `StormDetailView` – detailed storm metadata
  - `NotFoundView` / `ImagePicker` – reusable components

### MVVM-C

- **M**odel – data definitions (StormEntry, WeatherData)
- **V**iew – SwiftUI screens; no business logic
- **VM** – exposes state / actions, depends only on protocols (`WeatherServicing`)
- **C**oordinator – orchestrates navigation:
  - `AppCoordinator` changes active tab
  - `StormCoordinator` toggles Add Storm sheet

This keeps navigation logic out of views and view models.

## Weather API

- Provider: [Open-Meteo](https://open-meteo.com/)
- Endpoint: `/v1/forecast` with `current=temperature_2m,precipitation,wind_speed_10m`
- If the API fails, the app shows a `NotFoundView` with a retry button.

## Persistence (SwiftData)

- `StormEntry` is decorated with `@Model`
- App uses `.modelContainer(for: StormEntry.self)` in `StormChaserApp`
- Storms are queried with `@Query` in `StormListView`
- Insert and delete operations use `ModelContext`

## Running the App

1. Open `StormChaser.xcodeproj` (or add these sources into a fresh SwiftUI + SwiftData project).
2. Select an iOS Simulator (or device with camera if you want real photos).
3. Run the app.
4. Grant location permission when prompted.

### Permissions

- **Location**: required for fetching local weather and coordinates
- **Camera**: required to capture storm photos

## Features Implemented

- [x] Current weather view based on device location
- [x] Displays temperature, wind speed, and precipitation
- [x] “Not found” UI state if weather cannot be fetched
- [x] Capture photo with device camera
- [x] Add metadata: conditions (from weather), coordinates, date/time, notes, storm type
- [x] Local persistence using SwiftData
- [x] Navigation between Weather and Storm views (MVVM-C)

