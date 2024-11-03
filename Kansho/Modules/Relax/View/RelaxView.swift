//
//  RelaxView.swift
//  Kansho
//
//  Created by Dason Tiovino on 24/10/24.
//
import SwiftUI
import CoreHaptics

struct RelaxView: View {
    @EnvironmentObject var relaxViewModel: RelaxViewModel
    
    var body: some View {
        ZStack{
            VStack{
                RelaxViewMainLayout()
                    .environmentObject(relaxViewModel)
                
                RelaxViewFooterLayout()
                    .padding(.bottom, 100)
            }
        }.padding()
        .onAppear{
            self.relaxViewModel.hapticManager.prepareHapticEngine()
        }
    }
}

#Preview {
    RelaxView()
        .environmentObject(RelaxViewModel(hapticManager: HapticManager()))
}
