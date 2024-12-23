//
//  KanshoApp.swift
//  Kansho
//
//  Created by Dason Tiovino on 17/10/24.
//

import SwiftUI
import SwiftData

@main
struct KanshoApp: App {
    @StateObject var routingManager:RoutingManager = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(routingManager)
                .modelContainer(for: JournalModelLocal.self)
        }
    }
}
