//
//  StormListView.swift
//  StormChaser
//
//  Created by Smeet Chavda on 2025-12-03.
//

import SwiftUI
import SwiftData

struct StormListView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject private var stormCoordinator: StormCoordinator
    @Query(sort: \StormEntry.date, order: .reverse) private var storms: [StormEntry]
    @StateObject private var viewModel = StormListViewModel()
    
    var body: some View {
        List {
            ForEach(storms) { storm in
                NavigationLink {
                    StormDetailView(storm: storm)
                } label: {
                    HStack {
                        if let data = storm.imageData,
                           let uiImage = UIImage(data: data) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(.gray.opacity(0.2))
                                Image(systemName: "cloud.bolt.rain.fill")
                            }
                            .frame(width: 60, height: 60)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(storm.stormType)
                                .font(.headline)
                            Text(storm.notes)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(storm.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .onDelete(perform: deleteStorms)
        }
        .navigationTitle("Documented Storms")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    stormCoordinator.presentAddStorm()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $stormCoordinator.isPresentingAddStorm) {
            NavigationStack {
                AddStormView()
            }
        }
    }
    
    private func deleteStorms(at offsets: IndexSet) {
        for index in offsets {
            let storm = storms[index]
            viewModel.delete(storm: storm, in: context)
        }
    }
}
