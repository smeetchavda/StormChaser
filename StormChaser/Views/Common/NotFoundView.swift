//
//  NotFoundView.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import SwiftUI

struct NotFoundView: View {
    let message: String
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.largeTitle)
            Text("Not Found")
                .font(.headline)
            Text(message)
                .font(.subheadline)
                .multilineTextAlignment(.center)
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
