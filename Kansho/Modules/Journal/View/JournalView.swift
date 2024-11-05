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
    @State private var sheetModel: JournalModel = .init(
        title: "Empty",
        content: "Empty"
    )
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading, spacing: 0){
                JournalNotificationButton(image: relaxViewModel.plantImage){
                    // TODO: Trigger Relax
                }
                
                // MARK: Add Journal Button
                Button(action: {
                    journalViewModel.addJournal(JournalModel(
                        title: "Title",
                        content: "Content"
                    ))
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
                        showSheet = true
                        sheetModel = journal
                    }){
                        RoundedRectangle(cornerSize: CGSize(width: 30, height: 30))
                            .fill(.appPrimary)
                            .overlay {
                                VStack(alignment: .leading){
                                    Text($journal.wrappedValue.title)
                                        .font(.themeTitle3(weight: .heavy))
                                        .lineLimit(1)
                                    Text($journal.wrappedValue.content)
                                        .font(.themeBody())
                                        .lineLimit(1)
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
                        JournalDetailView(model: $sheetModel){
                            showSheet = false
                            journalViewModel.updateJournal(sheetModel)
                        }
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
}

#Preview{
    JournalView()
        .environmentObject(RelaxViewModel(hapticManager: .init()))
        .environmentObject(JournalViewModel())
}
