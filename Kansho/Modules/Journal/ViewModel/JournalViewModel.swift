//
//  JournalViewModel.swift
//  Kansho
//
//  Created by Dason Tiovino on 28/10/24.
//


import SwiftUI
import SwiftData
import Combine

class JournalViewModel: ObservableObject{
    
    private let container: ModelContainer!
    @Published var data: [JournalModel] = [
        .init(title: "Title", content: "Description"),
        .init(title: "Title2", content: "Description2"),
        .init(title: "Title3", content: "Description3"),
    ]
    
    init() {
        container = SwiftDataManager.shared.container
    }
    
    @MainActor public func fetch(){
        let fetchDescriptor = FetchDescriptor<JournalModelLocal>()
        do{
            let journal = try container.mainContext.fetch(fetchDescriptor)
            data = journal.compactMap{$0.toJournal()}
        }catch{
            debugPrint(error)
        }
    }
    
    @MainActor public func addJournal(_ journal: JournalModel) {
        do{
            container.mainContext.insert(journal.toJournalLocal())
            try container.mainContext.save()
        }catch{
            debugPrint("Add Journal Error: ", error)
        }
    }
    
    @MainActor public func removeJournal(_ journal: JournalModel) {
        do{
            container.mainContext.delete(journal.toJournalLocal())
            try container.mainContext.save()
        }catch{
            debugPrint("Remove Journal Error: ", error)
        }
    }
}
