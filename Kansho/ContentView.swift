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
    @State private var currentPage = 1
    
    var body: some View {
        GeometryReader{ geometry in
            let height = geometry.size.height / 100
            
            Color.background
            NavigationStack{
                ScrollViewReader { proxy in
                    ScrollView{
                        VStack(spacing: 0){
                            RelaxView()
                                .environmentObject(relaxViewModel)
                                .frame(height: geometry.size.height)
                                .animation(
                                    .easeInOut,
                                    value: relaxViewModel.isJournaling
                                )
                                .id(1)
                            
                            JournalView()
                                .environmentObject(relaxViewModel)
                                .environmentObject(journalViewModel)
                                .frame(height: geometry.size.height)
                                .animation(
                                    .easeInOut,
                                    value: relaxViewModel.isJournaling
                                )
                                .id(2)
                        } .onChange(of: currentPage) { newPage in
                            // Programmatically snap to the page when currentPage changes
                            withAnimation {
                                proxy.scrollTo(newPage, anchor: .top)
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    // Detect vertical swipes
                                    if value.translation.height < 0 { // Swipe up
                                        currentPage = min(currentPage + 1, 2)
                                    } else if value.translation.height > 0 { // Swipe down
                                        currentPage = max(currentPage - 1, 1)
                                    }
                                }
                        )
                    }
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
