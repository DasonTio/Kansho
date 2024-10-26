//
//  JournalView.swift
//  Kansho
//
//  Created by Dason Tiovino on 27/10/24.
//

import SwiftUI
import Combine

struct JournalView: View {
    @EnvironmentObject var relaxViewModel: RelaxViewModel
    @State private var showTimerNotification: Bool = false
    @State private var cancellables: [AnyCancellable] = []
    
    var body: some View {
        GeometryReader{ geometry in
            let height = geometry.size.height / 100
            let componentActive = showTimerNotification && relaxViewModel.isActive
            
            VStack (alignment: .leading, spacing: 0){
                Button(action: {
                    relaxViewModel.isJournaling.toggle()
                }){
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                        .fill(.appSecondary)
                        .overlay {
                            HStack{
                                VStack(alignment: .leading){
                                    Text("Relax Session")
                                        .font(.themeHeadline(weight: .heavy))
                                        .foregroundStyle(.appPrimary)
                                    
                                    Text("Let's calm down and unwind")
                                        .font(.themeBody())
                                        .foregroundStyle(.appPrimary)
                                }
                                
                                Spacer()
                                
                                Image(relaxViewModel.plantImage)
                                    .resizable()
                                    .scaledToFit()
                                    .animation(.easeInOut, value: relaxViewModel.plantImage)
                            }
                            .padding(.horizontal,20)
                            .clipped()
                            .cornerRadius(30)
                        }
                        .opacity(componentActive ? 1 : 0)
                        .frame(
                            height: componentActive ? height * 15 : 0
                        )
                        .animation(
                            .timingCurve(.circularEaseInOut, duration: 0.5),
                            value: componentActive
                        )
                        .padding(.horizontal, 15)
                        .padding(.top, 47)
                
                }
                
                
                RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                    .fill(.appPrimary)
                    .overlay {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
                            Text("Test")
                        }
                        .clipped()
                        .cornerRadius(30)
                    }
                    .frame(
                        maxHeight: .infinity
                    )
                    .animation(
                        .timingCurve(.circularEaseInOut, duration: 0.5),
                        value: componentActive
                    )
                    .padding(.horizontal, 15)
                    .padding(.top, 10)
            }
        }.onAppear {
            relaxViewModel.$isJournaling.sink(receiveValue: {value in
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false){_ in
                    showTimerNotification = value
                }
            }).store(in: &cancellables)
            
        }
    }
}

#Preview{
    JournalView()
        .environmentObject(RelaxViewModel(hapticManager: .init()))
}
