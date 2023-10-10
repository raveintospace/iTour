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
    
    var body: some View {
        ForEach(destination.landmarks.sorted(by: { $0.name < $1.name })) { landmark in
            Text(landmark.name)
        }
        .onDelete(perform: { indexSet in
            deleteLandmarks(indexSet)
        })
    }
    
    func deleteLandmarks(_ indexSet: IndexSet) {
        let sortedArray = destination.landmarks.sorted(by: { $0.name < $1.name })
        for index in indexSet {
            if let landmarkIndex = destination.landmarks.firstIndex(where: { $0.id == sortedArray[index].id }) {
                destination.landmarks.remove(at: landmarkIndex)
            }
        }
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
