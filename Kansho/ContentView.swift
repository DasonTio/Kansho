//
//  ContentView.swift
//  Kansho
//
//  Created by Dason Tiovino on 17/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var journalViewModel: JournalViewModel = .init()
    @StateObject var relaxViewModel: RelaxViewModel = .init(
        hapticManager: .init()
    )
    
    var body: some View {
        GeometryReader{ geometry in
            let height = geometry.size.height / 100
           
            Color.background
            NavigationStack{
                ZStack{
                    RelaxView()
                        .environmentObject(relaxViewModel)
                        .offset(
                            x: 0,
                            y: relaxViewModel.isJournaling ? height * -100 : 0
                        )
                        .animation(.easeInOut, value: relaxViewModel.isJournaling)
                    
                    JournalView()
                        .environmentObject(relaxViewModel)
                        .environmentObject(journalViewModel)
                        .offset(
                            x: 0,
                            y: relaxViewModel.isJournaling ? 0: height * 100
                        )
                        .animation(
                            .easeInOut,       
                            value: relaxViewModel.isJournaling
                        )
                }

            }
        }
        .ignoresSafeArea()
        .foregroundStyle(Color.appSecondary)
    }
}

#Preview {
    ContentView()
}
