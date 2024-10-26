//
//  ContentView.swift
//  Kansho
//
//  Created by Dason Tiovino on 17/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var hapticManager: HapticManager = .init()
    
    var body: some View {
        ZStack{
            Color.background
            NavigationStack{
                RelaxView()
                    .environmentObject(hapticManager)
            }
        }
        .ignoresSafeArea()
        .foregroundStyle(Color.appSecondary)
        
    }
}

#Preview {
    ContentView()
}
