//
//  DestinationListingView.swift
//  iTourSwiftData
//  https://youtu.be/mqLDroFreFE?si=sVmqsBanaXz5QMOc
//  Created by Uri on 3/10/23.
//  View for the user to sort the objects as they wish

import SwiftUI
import SwiftData

struct DestinationAllListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) { destination in
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: { indexSet in
                deleteDestinations(indexSet)
            })
        }
    }
    
    // custom init to overwrite our @Query macro
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }
    
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationAllListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
