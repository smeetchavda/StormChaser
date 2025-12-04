//
//  StormListViewModel.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import Foundation
import SwiftData

@MainActor
final class StormListViewModel: ObservableObject {
    func delete(storm: StormEntry, in context: ModelContext) {
        context.delete(storm)
        try? context.save()
    }
}
