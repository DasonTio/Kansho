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
    @State private var showSheet: Bool = false
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            JournalNotificationButton(image: relaxViewModel.plantImage){
                // TODO: Trigger Relax
                print("RELAX...")
            }
            
            // MARK: Add Journal Button
            Button(action: {
                // TODO: Call Add Journal
                journalViewModel.addJournal(JournalModel(
                    title: "Title",
                    content: "Content")
                )
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
            ForEach($journalViewModel.data, id: \.self){ $journal in
                Button(action: {
                    showSheet.toggle()
                }){
                    RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                        .fill(.appPrimary)
                        .overlay {
                            VStack(alignment: .leading){
                                Text($journal.wrappedValue.title)
                                    .font(.themeTitle3(weight: .heavy))
                                Text($journal.wrappedValue.content)
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
                }.sheet(isPresented: $showSheet){
                    JournalDetailView(
                        journalTitle: $journal.title,
                        journalContent: $journal.content
                    )
                }
            }
        }
        .frame(
            maxHeight: .infinity,
            alignment: Alignment(
                horizontal: .leading,
                vertical: .top
            )
        )
        .foregroundStyle(.appSecondary)
        .onAppear {
            journalViewModel.fetch()
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
