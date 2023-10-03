//
//  ContentView.swift
//  iTourSwiftData
//
//  Created by Uri on 2/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    // to add new destinations
    @State private var path = [Destination]()
    
    // to track order edited by user in DestinationListingView
    @State private var sortOrder = SortDescriptor(\Destination.name)
    
    var body: some View {
        NavigationStack(path: $path) {
            DestinationListingView(sort: sortOrder)
                .navigationTitle("iTour")
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
                .toolbar {
                    Button("Add destination", systemImage: "plus", action: addDestination)
                    
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Name").tag(SortDescriptor(\Destination.name))
                            Text("Date").tag(SortDescriptor(\Destination.date))
                            Text("Priority").tag(SortDescriptor(\Destination.priority, order: .reverse))
                        }
                        .pickerStyle(.inline)
                    }
                }
        }
    }
    
    // add new destination, put it in our model & show it in NavStack
    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
