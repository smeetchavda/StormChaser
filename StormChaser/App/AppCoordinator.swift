//
//  AppCoordinator.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation

final class AppCoordinator: ObservableObject {
    enum Tab {
        case weather
        case storms
    }
    
    @Published var selectedTab: Tab = .weather
    @Published var stormCoordinator = StormCoordinator()
    
    func showStormsTab() {
        selectedTab = .storms
    }
}
