//
//  ContentView.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @EnvironmentObject private var locationService: LocationService
    
    var body: some View {
        TabView(selection: $appCoordinator.selectedTab) {
            
            // WEATHER TAB
            NavigationStack {
                WeatherView()
                    .environmentObject(appCoordinator.stormCoordinator) // <— OPTIONAL but safe
            }
            .tabItem {
                Label("Weather", systemImage: "cloud.sun.fill")
            }
            .tag(AppCoordinator.Tab.weather)
            .onAppear {
                locationService.requestAuthorizationIfNeeded()
            }
            
            // STORMS TAB (IMPORTANT)
            NavigationStack {
                StormListView()
                    .environmentObject(appCoordinator.stormCoordinator)   // << IMPORTANT FIX
            }
            .tabItem {
                Label("Storms", systemImage: "bolt.fill")
            }
            .tag(AppCoordinator.Tab.storms)
        }
    }
}
