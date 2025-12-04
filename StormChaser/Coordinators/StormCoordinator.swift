//
//  StormCoordinator.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation

final class StormCoordinator: ObservableObject {
    @Published var isPresentingAddStorm: Bool = false
    
    func presentAddStorm() {
        isPresentingAddStorm = true
    }
    
    func dismissAddStorm() {
        isPresentingAddStorm = false
    }
}
