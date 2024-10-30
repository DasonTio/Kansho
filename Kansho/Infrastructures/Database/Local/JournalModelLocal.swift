//
//  JournalModelLocal.swift
//  Kansho
//
//  Created by Dason Tiovino on 29/10/24.
//

import SwiftData
import Foundation

@Model
struct JournalModelLocal: Identifiable {
    var id: UUID
    var title: String
    var content: String
    
    init(id: UUID = UUID(), title: String, content: String) {
        self.id = id
        self.title = title
        self.content = content
    }
}

extension JournalModelLocal{
    func toJournal() -> JournalModel {
        .init(id: id, title: title, content: content)
    }
}
