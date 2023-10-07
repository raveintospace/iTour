//
//  LandmarksView.swift
//  iTourSwiftData
//
//  Created by Uri on 7/10/23.
//

import SwiftUI
import SwiftData

struct LandmarksView: View {
    @Bindable var destination: Destination
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Landmark.name) var landmarks: [Landmark]
    
    var body: some View {
        ForEach(destination.landmarks) { landmark in
            Text(landmark.name)
        }
        .onDelete(perform: { indexSet in
            deleteLandmarks(indexSet)
        })
    }
    
    func deleteLandmarks(_ indexSet: IndexSet) {
        destination.landmarks.remove(atOffsets: indexSet)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        return LandmarksView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
