//
//  ContentView.swift
//  iTour
//
//  Created by Shreyas Sahoo on 09/05/24.
//

import SwiftUI
import SwiftData
struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""
    var body: some View {
        NavigationStack(path:$path) {
            DestinationListingView(sort:sortOrder, searchString: searchText)
            
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .searchable(text: $searchText)
            .toolbar{
                
                Button{
                    addDestination()
                } label: {
                    Image(systemName: "plus")
                }
                
                
                    Menu("sort", systemImage:"arrow.up.arrow.down"){
                        Picker("Sort Order",selection: $sortOrder){
                            Text("Name").tag(SortDescriptor(\Destination.name,order: .reverse))
                            Text("Date").tag(SortDescriptor(\Destination.date,order: .reverse))
                            Text("Priority").tag(SortDescriptor(\Destination.priority,order: .reverse))
                        
                                             
                        
                    }
                }
            }
        }
        .padding()
    }
    func addDestination(){
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
    private func addSamples(){
        let hyderabad = Destination(name:"hyderabad")
        let medak = Destination(name:"medak")
        let siddipet = Destination(name:"siddipet")
        modelContext.insert(hyderabad)
        modelContext.insert(medak)
        modelContext.insert(siddipet)
    }
   
}

#Preview {
    ContentView()
}
