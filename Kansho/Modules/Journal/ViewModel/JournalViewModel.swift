//
//  JournalViewModel.swift
//  Kansho
//
//  Created by Dason Tiovino on 28/10/24.
//


import SwiftUI
import Combine

class JournalViewModel: ObservableObject{
    
    @Published var data: [JournalModel] = [
        .init(title: "Title", description: "Description"),
        .init(title: "Title2", description: "Description2"),
        .init(title: "Title3", description: "Description3"),
    ]
    
    public func addJournal(_ journal: JournalModel) {
        data.append(journal)
    }
    
    public func removeJournal(_ journal: JournalModel) {
        data.removeAll(where: { $0.id == journal.id })
    }
    
    public func updateJournal(_ journal: JournalModel) {
        data.removeAll(where: { $0.id == journal.id })
        data.append(journal)
    }
}
