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
    @EnvironmentObject var journalViewModel: JournalViewModel
    @State private var showTimerNotification: Bool = false
    @State private var cancellables: [AnyCancellable] = []
    
    var body: some View {
        GeometryReader{ geometry in
            let height = geometry.size.height / 100
            let componentActive = showTimerNotification && relaxViewModel.isActive
            
            VStack (alignment: .leading, spacing: 0){
                // MARK: Journaling
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
                
                // MARK: Add Journal Button
                Button(action: {
                    // TODO: Call Add Journal
                }){
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                        .fill(.white)
                        .strokeBorder(style: StrokeStyle(
                            lineWidth: 2,
                            dash: [5])
                        )
                        .foregroundStyle(.appSecondary.opacity(0.4))
                        .overlay {
                            Image(systemName: "plus")
                                .font(.themeTitle3())
                                .foregroundStyle(.appSecondary)
                        }
                        .frame(height: 100)
                        .padding(.horizontal, 15)
                        .padding(.top, 10)
                }
                
                // MARK: List All Journal
                ForEach(journalViewModel.data, id: \.self){ journal in
                    Button(action: {
                        
                    }){
                        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                            .fill(.appPrimary)
                            .overlay {
                                VStack(alignment: .leading){
                                    Text(journal.title)
                                        .font(.themeTitle3(weight: .heavy))
                                    Text(journal.content)
                                        .font(.themeBody())
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    alignment: Alignment(
                                        horizontal: .leading,
                                        vertical: .center
                                    )
                                ).padding(.horizontal, 25)
                            }
                            .frame(height: 100)
                            .padding(.horizontal, 15)
                            .padding(.top, 10)
                    }
                }
            }
        }
        .foregroundStyle(.appSecondary)
        .onAppear {
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
        .environmentObject(JournalViewModel())
}
