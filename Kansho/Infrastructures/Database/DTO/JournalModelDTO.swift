//
//  JournalModelDTO.swift
//  Kansho
//
//  Created by Dason Tiovino on 29/10/24.
//

import Foundation

struct JournalModelDTO: Identifiable {
    let id: UUID
    let title: String
    let content: String
    
    init(id: UUID = UUID(), title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}

extension JournalModelDTO{
    func toJournalLocal() -> JournalModelLocal {
        .init(id: id, title: title, content: content)
    }
    func toJournal()-> JournalModel{
        .init(id: id, title: title, content: content)
    }
}
