//
//  JournalModel.swift
//  Kansho
//
//  Created by Dason Tiovino on 28/10/24.
//

import Foundation

struct JournalModel: Identifiable, Codable, Hashable {
    var id: UUID = .init()
    var title: String
    var content: String
}

extension JournalModel{
    func toJournalLocal() -> JournalModelLocal {
        .init(id: id, title: title, content: content)
    }
}
