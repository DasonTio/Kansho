//
//  ContentView.swift
//  Kansho
//
//  Created by Dason Tiovino on 17/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.background
            NavigationStack{
                RelaxView()
            }
        }
        .ignoresSafeArea()
        .foregroundStyle(Color.appSecondary)
        
    }
}

#Preview {
    ContentView()
}
