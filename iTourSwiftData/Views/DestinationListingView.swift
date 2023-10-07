//
//  DestinationListingView.swift
//  iTourSwiftData
//  https://youtu.be/mqLDroFreFE?si=sVmqsBanaXz5QMOc
//  Created by Uri on 3/10/23.
//  View for the user to sort the objects as they wish

import SwiftUI
import SwiftData

struct DestinationListingView: View {
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
//    init(sort: SortDescriptor<Destination>, searchString: String) {
//        _destinations = Query(filter: #Predicate {
//            if searchString.isEmpty {
//                return true
//            } else {
//                return $0.name.localizedStandardContains(searchString)
//            }
//        }, sort: [sort])
//    }
    
    // uncomment to show results that match date or priority
    init(sort: SortDescriptor<Destination>, isFuture: Bool, searchString: String) {
            let now = Date.now
            
            _destinations = Query(filter: #Predicate {
                // $0.priority >= 2
                if isFuture && !searchString.isEmpty {
                    return $0.name.localizedStandardContains(searchString) // and $0.date > now
                } else if isFuture && searchString.isEmpty {
                    return $0.date > now
                } else {
                   return true
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
    DestinationListingView(sort: SortDescriptor(\Destination.name), isFuture: true, searchString: "")
}
