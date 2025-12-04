//
//  StormChaserApp.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import SwiftUI
import SwiftData

@main
struct StormChaserApp: App {
    @StateObject private var appCoordinator = AppCoordinator()
    @StateObject private var locationService = LocationService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appCoordinator)
                .environmentObject(locationService)
        }
        .modelContainer(for: StormEntry.self)
    }
}
