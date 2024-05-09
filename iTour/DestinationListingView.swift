//
//  DestinationListingView.swift
//  iTour
//
//  Created by Shreyas Sahoo on 09/05/24.
//

import SwiftUI
import SwiftData
struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort : [SortDescriptor(\Destination.priority, order: .reverse),SortDescriptor(\Destination.name, order: .forward)]) var destinations : [Destination]

    var body: some View {
        List{
            ForEach(destinations){ destination in
                NavigationLink(value:destination){
                    VStack(alignment:.leading){
                        Text(destination.name)
                        Text(destination.date.formatted(date: .long, time : .shortened))
                    }
                }
            
                
            }
            .onDelete(perform: deleteDestination)
        }
        
    }
    init(sort: SortDescriptor<Destination>, searchString: String){
        
        _destinations = Query(filter : #Predicate{
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        } ,sort:[sort])
    }
    private func deleteDestination(_ indexSet : IndexSet){
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort:SortDescriptor(\Destination.name),searchString: "")
}
