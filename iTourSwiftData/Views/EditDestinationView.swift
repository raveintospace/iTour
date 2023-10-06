//
//  EditDestinationView.swift
//  iTourSwiftData
//
//  Created by Uri on 2/10/23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Bindable var destination: Destination
    @State private var newLandmarkName = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
                .autocorrectionDisabled()
            TextField("Details", text: $destination.details, axis: .vertical)
                .autocorrectionDisabled()
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.segmented)
            }
            
            Section("Landmarks") {
                ForEach(destination.landmarks) { landmark in
                    Text(landmark.name)
                }
                .onDelete(perform: { indexSet in
                    deleteLandmarks(indexSet)
                })
                
                HStack {
                    TextField("Add a new landmark in \(destination.name)", text: $newLandmarkName).autocorrectionDisabled()
                    
                    Button("Add", action: addLandmark)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addLandmark() {
        guard newLandmarkName.isEmpty == false else { return }
        
        withAnimation {
            let landmark = Landmark(name: newLandmarkName)
            destination.landmarks.append(landmark)
            newLandmarkName = ""
        }
    }
    
    func deleteLandmarks(_ indexSet: IndexSet) {
        destination.landmarks.remove(atOffsets: indexSet)
    }
}

#Preview {
    // only to work with preview, not used in the real app
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "Example destination", details: "Example details go here and will automatically expand vertically as they are edited.")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
