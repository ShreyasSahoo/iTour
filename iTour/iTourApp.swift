//
//  iTourApp.swift
//  iTour
//
//  Created by Shreyas Sahoo on 09/05/24.
//

import SwiftUI
import SwiftData
@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
