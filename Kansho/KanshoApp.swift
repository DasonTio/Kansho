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
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: JournalModelLocal.self)
        }
    }
}
