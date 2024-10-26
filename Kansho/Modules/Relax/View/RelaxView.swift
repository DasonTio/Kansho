//
//  RelaxView.swift
//  Kansho
//
//  Created by Dason Tiovino on 24/10/24.
//
import SwiftUI
import CoreHaptics

struct RelaxView: View {
    @EnvironmentObject var hapticManager: HapticManager
    
    var body: some View {
        ZStack{
            VStack{
                RelaxViewMainLayout()
                    .environmentObject(hapticManager)
                
                RelaxViewFooterLayout()
                
            }
        }.padding()
        .onAppear{
            self.hapticManager.prepareHapticEngine()
        }
    }
}

#Preview {
    RelaxView()
        .environmentObject(HapticManager())
}
