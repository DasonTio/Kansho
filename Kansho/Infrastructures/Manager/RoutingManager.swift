//
//  RoutingManager.swift
//  Kansho
//
//  Created by Dason Tiovino on 05/11/24.
//

import SwiftUI

class RoutingManager: ObservableObject {    
    static let shared = RoutingManager()

    enum Destination {
        case relaxView
        case journalView
        case journalCameraView
    }
    
    @Published var path: NavigationPath = .init()
    @Published var selectedJournal: JournalModel?

    func navigate(to destination: Destination, with data: UIImage? = nil) {
        path.append(destination)
    }
    
    func back() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
